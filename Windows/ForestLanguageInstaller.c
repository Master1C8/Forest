#define WIN32_LEAN_AND_MEAN

#include <windows.h>
#include <commctrl.h>
#include <shellapi.h>
#include <shlobj.h>
#include <stdio.h>
#include <wchar.h>
#include <wincrypt.h>
#include "Locales.h"

#define APP_TITLE L"VN Revival — The Forest of Love"
#define WM_INSTALL_FINISHED (WM_APP + 1)
#define ID_RETRY 1001
#define ID_CHOOSE 1002
#define ID_LAUNCH 1003
#define ID_LANGUAGE 1004

static HWND languagePicker;
static int selectedLocale;

static HWND statusLabel;
static HWND progressBar;
static HWND retryButton;
static HWND chooseButton;
static HWND launchButton;
static HFONT uiFont;
static HFONT titleFont;
static volatile LONG installationRunning;
static WCHAR applicationDirectory[MAX_PATH * 4];
static WCHAR selectedGamePath[MAX_PATH * 4];
static WCHAR installedGamePath[MAX_PATH * 4];
static WCHAR statusFile[MAX_PATH * 4];
static WCHAR gamePathFile[MAX_PATH * 4];
static WCHAR runDirectory[MAX_PATH * 4];

static void setControlFont(HWND control) {
    SendMessageW(control, WM_SETFONT, (WPARAM)uiFont, TRUE);
}

static void showInstallingState(void) {
    SetWindowTextW(statusLabel, L"Installing the selected language…");
    ShowWindow(progressBar, SW_SHOW);
    SendMessageW(progressBar, PBM_SETMARQUEE, TRUE, 35);
    EnableWindow(languagePicker, FALSE);
    EnableWindow(retryButton, FALSE);
    EnableWindow(chooseButton, FALSE);
    ShowWindow(launchButton, SW_HIDE);
}

static void showFailureState(const WCHAR *message) {
    SetWindowTextW(statusLabel, message && message[0] ? message : L"Installation did not finish. Check the message and try again.");
    SendMessageW(progressBar, PBM_SETMARQUEE, FALSE, 0);
    ShowWindow(progressBar, SW_HIDE);
    EnableWindow(languagePicker, TRUE);
    EnableWindow(retryButton, TRUE);
    EnableWindow(chooseButton, TRUE);
    ShowWindow(launchButton, SW_HIDE);
}

static void showSuccessState(void) {
    SetWindowTextW(statusLabel, L"Language applied. You can launch the game or choose another language.");
    SendMessageW(progressBar, PBM_SETMARQUEE, FALSE, 0);
    ShowWindow(progressBar, SW_HIDE);
    EnableWindow(languagePicker, TRUE);
    EnableWindow(retryButton, TRUE);
    EnableWindow(chooseButton, TRUE);
    ShowWindow(launchButton, SW_SHOW);
}

static BOOL readUtf8File(const WCHAR *path, WCHAR *destination, DWORD capacity) {
    HANDLE file = CreateFileW(path, GENERIC_READ, FILE_SHARE_READ | FILE_SHARE_WRITE, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
    if (file == INVALID_HANDLE_VALUE) return FALSE;

    char buffer[4096];
    DWORD bytesRead = 0;
    BOOL read = ReadFile(file, buffer, sizeof(buffer) - 1, &bytesRead, NULL);
    CloseHandle(file);
    if (!read || bytesRead == 0) return FALSE;
    buffer[bytesRead] = '\0';

    int converted = MultiByteToWideChar(CP_UTF8, 0, buffer, -1, destination, (int)capacity);
    return converted > 0;
}

static BOOL readStatusMessage(WCHAR *destination, DWORD capacity) {
    return readUtf8File(statusFile, destination, capacity);
}

/* Quote a single Windows CRT argument, including trailing backslashes. */
static BOOL quoteArgument(const WCHAR *input, WCHAR *output, size_t capacity) {
    size_t at = 0, slashes = 0;
    if (capacity < 3) return FALSE;
    output[at++] = L'"';
    for (const WCHAR *p = input; ; ++p) {
        if (*p == L'\\') { ++slashes; continue; }
        size_t copies = (*p == L'"' || !*p) ? slashes * 2 : slashes;
        if (at + copies + 3 >= capacity) return FALSE;
        while (copies--) output[at++] = L'\\';
        slashes = 0;
        if (!*p) break;
        if (*p == L'"') output[at++] = L'\\';
        output[at++] = *p;
    }
    output[at++] = L'"'; output[at] = 0; return TRUE;
}
static BOOL fileHashMatches(const WCHAR *path, const WCHAR *expected) {
    HCRYPTPROV provider = 0; HCRYPTHASH hash = 0;
    HANDLE file = CreateFileW(path, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, 0, NULL);
    if (file == INVALID_HANDLE_VALUE) return FALSE;
    BOOL ok = CryptAcquireContextW(&provider, NULL, NULL, PROV_RSA_AES, CRYPT_VERIFYCONTEXT);
    if (ok) ok = CryptCreateHash(provider, CALG_SHA_256, 0, 0, &hash);
    BYTE block[65536]; DWORD size = 0;
    while (ok) {
        ok = ReadFile(file, block, sizeof block, &size, NULL);
        if (!ok || !size) break;
        ok = CryptHashData(hash, block, size, 0);
    }
    BYTE digest[32]; DWORD digestSize = sizeof digest;
    if (ok) ok = CryptGetHashParam(hash, HP_HASHVAL, digest, &digestSize, 0);
    WCHAR actual[65];
    if (ok) {
        for (int i = 0; i < 32; ++i) swprintf(actual + i * 2, 3, L"%02x", digest[i]);
        actual[64] = 0; ok = wcscmp(actual, expected) == 0;
    }
    if (hash) CryptDestroyHash(hash);
    if (provider) CryptReleaseContext(provider, 0);
    CloseHandle(file); return ok;
}
static BOOL verifyCompanions(void) {
    WCHAR path[MAX_PATH * 4];
    swprintf(path, _countof(path), L"%ls\\Resources\\install.ps1", applicationDirectory);
    if (!fileHashMatches(path, FOREST_SCRIPT_SHA)) return FALSE;
    swprintf(path, _countof(path), L"%ls\\Resources\\ForestInstaller.cs", applicationDirectory);
    if (!fileHashMatches(path, FOREST_CORE_SHA)) return FALSE;
    swprintf(path, _countof(path), L"%ls\\Resources\\forest-bundle.exe", applicationDirectory);
    return fileHashMatches(path, FOREST_CODEC_SHA);
}

static DWORD WINAPI installWorker(LPVOID parameter) {
    HWND window = (HWND)parameter;
    WCHAR scriptPath[MAX_PATH * 4];
    WCHAR commandLine[MAX_PATH * 40];
    WCHAR systemDirectory[MAX_PATH];
    WCHAR powershellPath[MAX_PATH * 2];

    swprintf(scriptPath, _countof(scriptPath), L"%ls\\Resources\\install.ps1", applicationDirectory);
    GetSystemDirectoryW(systemDirectory, _countof(systemDirectory));
    swprintf(powershellPath, _countof(powershellPath), L"%ls\\WindowsPowerShell\\v1.0\\powershell.exe", systemDirectory);

    WCHAR qPower[MAX_PATH * 4], qScript[MAX_PATH * 4], qBase[MAX_PATH * 4];
    WCHAR qStatus[MAX_PATH * 4], qResult[MAX_PATH * 4], qGame[MAX_PATH * 4];
    if (!quoteArgument(powershellPath, qPower, _countof(qPower)) ||
        !quoteArgument(scriptPath, qScript, _countof(qScript)) ||
        !quoteArgument(applicationDirectory, qBase, _countof(qBase)) ||
        !quoteArgument(statusFile, qStatus, _countof(qStatus)) ||
        !quoteArgument(gamePathFile, qResult, _countof(qResult)) ||
        !quoteArgument(selectedGamePath, qGame, _countof(qGame))) {
        InterlockedExchange(&installationRunning, 0);
        PostMessageW(window, WM_INSTALL_FINISHED, 1, 0); return 1;
    }
    swprintf(commandLine, _countof(commandLine),
        L"%ls -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -File %ls -BaseDirectory %ls -StatusFile %ls -GamePathFile %ls -Locale %ls -PayloadSha256 %ls -CodecSha256 %ls -GamePath %ls",
        qPower, qScript, qBase, qStatus, qResult, localeCodes[selectedLocale], FOREST_PAYLOAD_SHA, FOREST_CODEC_SHA, qGame);

    DeleteFileW(statusFile);
    DeleteFileW(gamePathFile);
    installedGamePath[0] = L'\0';
    STARTUPINFOW startup = {0};
    PROCESS_INFORMATION process = {0};
    startup.cb = sizeof(startup);
    BOOL started = CreateProcessW(
        powershellPath,
        commandLine,
        NULL,
        NULL,
        FALSE,
        CREATE_NO_WINDOW,
        NULL,
        applicationDirectory,
        &startup,
        &process
    );

    DWORD exitCode = 1;
    if (started) {
        WaitForSingleObject(process.hProcess, INFINITE);
        GetExitCodeProcess(process.hProcess, &exitCode);
        CloseHandle(process.hThread);
        CloseHandle(process.hProcess);
    } else {
        FILE *status = _wfopen(statusFile, L"wb");
        if (status) {
            fputs("Windows PowerShell could not be started.", status);
            fclose(status);
        }
    }

    InterlockedExchange(&installationRunning, 0);
    PostMessageW(window, WM_INSTALL_FINISHED, (WPARAM)exitCode, 0);
    return 0;
}

static void startInstallation(HWND window) {
    if (!verifyCompanions()) {
        showFailureState(L"Installer files are missing or modified. Extract the complete ZIP again.");
        return;
    }
    selectedLocale = (int)SendMessageW(languagePicker, CB_GETCURSEL, 0, 0);
    if (selectedLocale < 0 || selectedLocale >= (int)_countof(localeCodes)) return;
    if (InterlockedCompareExchange(&installationRunning, 1, 0) != 0) return;
    showInstallingState();
    SetTimer(window, 1, 300, NULL);
    HANDLE thread = CreateThread(NULL, 0, installWorker, window, 0, NULL);
    if (!thread) {
        InterlockedExchange(&installationRunning, 0);
        KillTimer(window, 1);
        showFailureState(L"The installer worker could not be started.");
        return;
    }
    CloseHandle(thread);
}

static BOOL chooseGameFolder(HWND owner) {
    BROWSEINFOW browse = {0};
    browse.hwndOwner = owner;
    browse.lpszTitle = L"Choose the folder containing The Forest of Love.exe";
    browse.ulFlags = BIF_RETURNONLYFSDIRS | BIF_NEWDIALOGSTYLE;
    PIDLIST_ABSOLUTE item = SHBrowseForFolderW(&browse);
    if (!item) return FALSE;
    BOOL resolved = SHGetPathFromIDListW(item, selectedGamePath);
    CoTaskMemFree(item);
    return resolved;
}

static LRESULT CALLBACK windowProcedure(HWND window, UINT message, WPARAM wParam, LPARAM lParam) {
    (void)lParam;
    switch (message) {
        case WM_CREATE: {
            uiFont = CreateFontW(-18, 0, 0, 0, FW_NORMAL, FALSE, FALSE, FALSE, DEFAULT_CHARSET,
                OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, CLEARTYPE_QUALITY, DEFAULT_PITCH, L"Segoe UI");
            HWND title = CreateWindowW(L"STATIC", L"The Forest of Love", WS_CHILD | WS_VISIBLE,
                36, 24, 520, 36, window, NULL, NULL, NULL);
            titleFont = CreateFontW(-25, 0, 0, 0, FW_SEMIBOLD, FALSE, FALSE, FALSE, DEFAULT_CHARSET,
                OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, CLEARTYPE_QUALITY, DEFAULT_PITCH, L"Segoe UI");
            SendMessageW(title, WM_SETFONT, (WPARAM)titleFont, TRUE);
            HWND label = CreateWindowW(L"STATIC", L"Choose your language", WS_CHILD | WS_VISIBLE,
                38, 74, 500, 26, window, NULL, NULL, NULL);
            languagePicker = CreateWindowW(L"COMBOBOX", NULL,
                WS_CHILD | WS_VISIBLE | WS_TABSTOP | CBS_DROPDOWNLIST | WS_VSCROLL,
                38, 103, 500, 360, window, (HMENU)ID_LANGUAGE, NULL, NULL);
            for (unsigned i = 0; i < _countof(localeNames); ++i)
                SendMessageW(languagePicker, CB_ADDSTRING, 0, (LPARAM)localeNames[i]);
            SendMessageW(languagePicker, CB_SETCURSEL, 0, 0);
            statusLabel = CreateWindowW(L"STATIC", L"Close the game, select a language and click Install language.", WS_CHILD | WS_VISIBLE,
                38, 153, 500, 94, window, NULL, NULL, NULL);
            progressBar = CreateWindowW(PROGRESS_CLASSW, NULL, WS_CHILD | PBS_MARQUEE,
                38, 254, 500, 12, window, NULL, NULL, NULL);
            retryButton = CreateWindowW(L"BUTTON", L"Install language", WS_CHILD | WS_VISIBLE | WS_TABSTOP | BS_DEFPUSHBUTTON,
                38, 282, 170, 38, window, (HMENU)ID_RETRY, NULL, NULL);
            chooseButton = CreateWindowW(L"BUTTON", L"Choose game…", WS_CHILD | WS_VISIBLE | WS_TABSTOP | BS_PUSHBUTTON,
                222, 282, 160, 38, window, (HMENU)ID_CHOOSE, NULL, NULL);
            launchButton = CreateWindowW(L"BUTTON", L"Launch game", WS_CHILD | WS_TABSTOP | BS_PUSHBUTTON,
                394, 282, 145, 38, window, (HMENU)ID_LAUNCH, NULL, NULL);
            HWND hint = CreateWindowW(L"STATIC", L"Windows game 0.45 • Saves and settings are preserved", WS_CHILD | WS_VISIBLE,
                38, 338, 500, 26, window, NULL, NULL, NULL);
            setControlFont(label); setControlFont(languagePicker);
            setControlFont(statusLabel); setControlFont(retryButton);
            setControlFont(chooseButton); setControlFont(launchButton); setControlFont(hint);
            return 0;
        }
        case WM_TIMER: {
            WCHAR text[2048] = {0};
            if (readStatusMessage(text, _countof(text))) SetWindowTextW(statusLabel, text);
            return 0;
        }
        case WM_INSTALL_FINISHED: {
            KillTimer(window, 1);
            DWORD exitCode = (DWORD)wParam;
            if (exitCode == 0) {
                if (readUtf8File(gamePathFile, installedGamePath, _countof(installedGamePath))) {
                    showSuccessState();
                } else {
                    showFailureState(L"The game path was not recorded. Retry the installation.");
                }
            } else {
                WCHAR details[2048] = {0};
                if (!readStatusMessage(details, _countof(details)) && exitCode == 2) {
                    wcscpy(details, L"The Forest of Love was not found. Choose the game folder.");
                }
                showFailureState(details);
            }
            return 0;
        }
        case WM_COMMAND:
            if (LOWORD(wParam) == ID_LANGUAGE && HIWORD(wParam) == CBN_SELCHANGE) {
                ShowWindow(launchButton, SW_HIDE);
                SetWindowTextW(statusLabel, L"Click Install language to apply this selection.");
                return 0;
            }
            switch (LOWORD(wParam)) {
                case ID_RETRY:
                    startInstallation(window);
                    return 0;
                case ID_CHOOSE:
                    if (chooseGameFolder(window)) {
                        SetWindowTextW(statusLabel, selectedGamePath);
                        ShowWindow(launchButton, SW_HIDE);
                    }
                    return 0;
                case ID_LAUNCH:
                    if (installedGamePath[0]) {
                        WCHAR smapiPath[MAX_PATH * 4];
                        swprintf(smapiPath, _countof(smapiPath), L"%ls\\The Forest of Love.exe", installedGamePath);
                        if (GetFileAttributesW(smapiPath) == INVALID_FILE_ATTRIBUTES) {
                            showFailureState(L"The game was not found. Retry the installation.");
                        } else if ((INT_PTR)ShellExecuteW(window, L"open", smapiPath, NULL, installedGamePath, SW_SHOWNORMAL) <= 32) {
                            showFailureState(L"The game could not be started. Retry the installation.");
                        } else {
                            DestroyWindow(window);
                        }
                    } else {
                        showFailureState(L"The game path is unavailable. Retry the installation.");
                    }
                    return 0;
            }
            break;
        case WM_CLOSE:
            if (InterlockedCompareExchange(&installationRunning, 0, 0) != 0) {
                MessageBoxW(window, L"Installation is still in progress.", APP_TITLE, MB_OK | MB_ICONINFORMATION);
                return 0;
            }
            DestroyWindow(window);
            return 0;
        case WM_DESTROY:
            if (uiFont) DeleteObject(uiFont);
            if (titleFont) DeleteObject(titleFont);
            DeleteFileW(statusFile);
            DeleteFileW(gamePathFile);
            RemoveDirectoryW(runDirectory);
            PostQuitMessage(0);
            return 0;
    }
    return DefWindowProcW(window, message, wParam, lParam);
}

int WINAPI wWinMain(HINSTANCE instance, HINSTANCE previous, PWSTR commandLine, int showCommand) {
    (void)previous;
    (void)commandLine;

    INITCOMMONCONTROLSEX controls = {sizeof(controls), ICC_PROGRESS_CLASS};
    InitCommonControlsEx(&controls);
    CoInitializeEx(NULL, COINIT_APARTMENTTHREADED);

    WCHAR executablePath[MAX_PATH * 4];
    DWORD length = GetModuleFileNameW(NULL, executablePath, _countof(executablePath));
    if (length == 0 || length >= _countof(executablePath)) return 1;
    WCHAR *separator = wcsrchr(executablePath, L'\\');
    if (!separator) return 1;
    if (separator == executablePath + 2) separator[1] = L'\0';
    else *separator = L'\0';
    wcscpy(applicationDirectory, executablePath);

    WCHAR temporaryDirectory[MAX_PATH * 2];
    DWORD tempLength = GetTempPathW(_countof(temporaryDirectory), temporaryDirectory);
    if (!tempLength || tempLength >= _countof(temporaryDirectory)) return 1;
    GUID runId; WCHAR unique[40];
    if (FAILED(CoCreateGuid(&runId)) || !StringFromGUID2(&runId, unique, _countof(unique))) return 1;
    swprintf(runDirectory, _countof(runDirectory), L"%lsVNRevival-Forest-%ls", temporaryDirectory, unique);
    if (!CreateDirectoryW(runDirectory, NULL)) return 1;
    swprintf(statusFile, _countof(statusFile), L"%ls\\status.txt", runDirectory);
    swprintf(gamePathFile, _countof(gamePathFile), L"%ls\\game.txt", runDirectory);

    WNDCLASSEXW windowClass = {0};
    windowClass.cbSize = sizeof(windowClass);
    windowClass.lpfnWndProc = windowProcedure;
    windowClass.hInstance = instance;
    windowClass.hIcon = LoadIconW(instance, MAKEINTRESOURCEW(1));
    windowClass.hIconSm = windowClass.hIcon;
    windowClass.hCursor = LoadCursorW(NULL, IDC_ARROW);
    windowClass.hbrBackground = (HBRUSH)(COLOR_WINDOW + 1);
    windowClass.lpszClassName = L"VNRevivalForestInstallerWindow";
    if (!RegisterClassExW(&windowClass)) return 1;

    const int width = 590;
    const int height = 420;
    RECT desktop;
    SystemParametersInfoW(SPI_GETWORKAREA, 0, &desktop, 0);
    int x = desktop.left + (desktop.right - desktop.left - width) / 2;
    int y = desktop.top + (desktop.bottom - desktop.top - height) / 2;
    HWND window = CreateWindowExW(
        0,
        windowClass.lpszClassName,
        APP_TITLE,
        WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU | WS_MINIMIZEBOX,
        x,
        y,
        width,
        height,
        NULL,
        NULL,
        instance,
        NULL
    );
    if (!window) return 1;

    ShowWindow(window, showCommand);
    UpdateWindow(window);
    MSG message;
    while (GetMessageW(&message, NULL, 0, 0) > 0) {
        if (!IsDialogMessageW(window, &message)) {
            TranslateMessage(&message); DispatchMessageW(&message);
        }
    }
    CoUninitialize();
    return (int)message.wParam;
}
