using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using UnityEngine;

namespace PixelCrushers.DialogueSystem;

public class FormattedText
{
	public static readonly FormattedText empty = new FormattedText();

	public static readonly Emphasis[] noEmphases = new Emphasis[0];

	public const int NoAssignedPosition = -1;

	public const int NoPicOverride = 0;

	public string text { get; set; }

	public Emphasis[] emphases { get; set; }

	public bool italic { get; set; }

	public int position { get; set; }

	public bool forceMenu { get; set; }

	public bool forceAuto { get; set; }

	public bool noSubtitle { get; set; }

	public int pic { get; set; }

	public int picActor { get; set; }

	public int picConversant { get; set; }

	public string variableInputPrompt { get; set; }

	public bool hasVariableInputPrompt => !string.IsNullOrEmpty(variableInputPrompt);

	public int subtitlePanelNumber { get; set; }

	public FormattedText(string text = null, Emphasis[] emphases = null, bool italic = false, int position = -1, bool forceMenu = true, bool forceAuto = false, int pic = 0, int picActor = 0, int picConversant = 0, string variableInputPrompt = null, int subtitlePanelNumber = -1, bool noSubtitle = false)
	{
		this.text = text ?? string.Empty;
		this.emphases = emphases ?? noEmphases;
		this.italic = italic;
		this.position = position;
		this.forceMenu = forceMenu;
		this.forceAuto = forceAuto;
		this.pic = pic;
		this.picActor = picActor;
		this.picConversant = picConversant;
		this.variableInputPrompt = variableInputPrompt;
		this.subtitlePanelNumber = subtitlePanelNumber;
		this.noSubtitle = noSubtitle;
	}

	public static FormattedText Parse(string rawText, EmphasisSetting[] emphasisSettings = null)
	{
		if (emphasisSettings == null && DialogueManager.instance != null)
		{
			emphasisSettings = DialogueManager.masterDatabase.emphasisSettings;
		}
		string text = rawText ?? string.Empty;
		ReplaceLuaTags(ref text);
		string text2 = ExtractVariableInputPrompt(ref text);
		ReplaceVarTags(ref text);
		ReplaceAutocaseTags(ref text);
		ReplacePipes(ref text);
		int num = 0;
		int num2 = 0;
		int num3 = 0;
		if (text.Contains("[pic"))
		{
			num = ExtractPicTag("\\[pic=[0-9a-zA-z_]+\\]", ref text);
			num2 = ExtractPicTag("\\[pica=[0-9a-zA-z_]+\\]", ref text);
			num3 = ExtractPicTag("\\[picc=[0-9a-zA-z_]+\\]", ref text);
		}
		bool flag = ExtractTag("[a]", ref text);
		bool flag2 = ExtractTag("[f]", ref text);
		bool flag3 = ExtractTag("[auto]", ref text);
		bool flag4 = ExtractTag("[nosubtitle]", ref text);
		int num4 = ExtractPositionTag(ref text);
		int num5 = ExtractPanelNumberTag(ref text);
		Emphasis[] array = (DialogueManager.instance.displaySettings.subtitleSettings.richTextEmphases ? ReplaceEmphasisTagsWithRichText(ref text, emphasisSettings) : ExtractEmphasisTags(ref text, emphasisSettings));
		return new FormattedText(text, array, flag, num4, flag2, flag3, num, num2, num3, text2, num5, flag4);
	}

	public static string ParseCode(string rawText)
	{
		string text = rawText ?? string.Empty;
		if (text.Contains("["))
		{
			ReplaceLuaTags(ref text);
			ReplaceVarTags(ref text);
		}
		return text;
	}

	private static void ReplacePipes(ref string text)
	{
		if (text.Contains("|"))
		{
			text = text.Replace("|", "\n");
		}
	}

	private static void ReplaceLuaTags(ref string text)
	{
		if (!text.Contains("[lua("))
		{
			return;
		}
		Regex regex = new Regex("\\[lua\\((?!lua).*\\)\\]");
		int num = text.Length - 1;
		int num2 = 0;
		while (num >= 0 && num2 < 100)
		{
			num2++;
			int num3 = text.LastIndexOf("[lua(", num, StringComparison.OrdinalIgnoreCase);
			num = num3 - 1;
			if (num3 < 0)
			{
				continue;
			}
			string text2 = text.Substring(0, num3);
			string input = text.Substring(num3);
			string text3 = regex.Replace(input, delegate(Match match)
			{
				string text4 = match.Value.Substring(5, match.Value.Length - 7).Trim();
				if (!text4.StartsWith("return "))
				{
					text4 = "return " + text4;
				}
				try
				{
					return Lua.Run(text4, DialogueDebug.logInfo).asString;
				}
				catch (Exception)
				{
					if (DialogueDebug.logWarnings)
					{
						Debug.LogWarning(string.Format("{0}: Lua failed: '{1}'", new object[2] { "Dialogue System", text4 }));
					}
					return string.Empty;
				}
			});
			text = text2 + text3;
		}
	}

	private static void ReplaceVarTags(ref string text)
	{
		if (!text.Contains("[var="))
		{
			return;
		}
		Regex regex = new Regex("\\[var=[^\\]]*\\]");
		int num = text.Length - 1;
		int num2 = 0;
		while (num >= 0 && num2 < 100)
		{
			num2++;
			int num3 = text.LastIndexOf("[var=", num, StringComparison.OrdinalIgnoreCase);
			num = num3 - 1;
			if (num3 < 0)
			{
				continue;
			}
			string text2 = text.Substring(0, num3);
			string input = text.Substring(num3);
			string text3 = regex.Replace(input, delegate(Match match)
			{
				string text4 = match.Value.Substring(5, match.Value.Length - 6).Trim();
				try
				{
					return DialogueLua.GetVariable(text4).asString;
				}
				catch (Exception)
				{
					if (DialogueDebug.logWarnings)
					{
						Debug.LogWarning(string.Format("{0}: Failed to get variable: '{1}'", new object[2] { "Dialogue System", text4 }));
					}
					return string.Empty;
				}
			});
			text = text2 + text3;
		}
	}

	private static void ReplaceAutocaseTags(ref string text)
	{
		if (!text.Contains("[autocase="))
		{
			return;
		}
		Regex regex = new Regex("\\[autocase=[^\\]]*\\]");
		int num = text.Length - 1;
		int num2 = 0;
		while (num >= 0 && num2 < 100)
		{
			num2++;
			int num3 = text.LastIndexOf("[autocase=", num, StringComparison.OrdinalIgnoreCase);
			num = num3 - 1;
			if (num3 < 0)
			{
				continue;
			}
			string text2 = text.Substring(0, num3);
			bool capitalize = ShouldCapitalizeNextChar(text2);
			string input = text.Substring(num3);
			string text3 = regex.Replace(input, delegate(Match match)
			{
				string text4 = match.Value.Substring(10, match.Value.Length - 11).Trim();
				try
				{
					string text5 = DialogueLua.GetVariable(text4).asString;
					if (text5.Length > 0)
					{
						text5 = SetCapitalization(capitalize, text5);
					}
					return text5;
				}
				catch (Exception)
				{
					if (DialogueDebug.logWarnings)
					{
						Debug.LogWarning(string.Format("{0}: Failed to get variable: '{1}'", new object[2] { "Dialogue System", text4 }));
					}
					return string.Empty;
				}
			});
			text = text2 + text3;
		}
	}

	private static bool ShouldCapitalizeNextChar(string s)
	{
		if (string.IsNullOrEmpty(s))
		{
			return true;
		}
		for (int num = s.Length - 1; num >= 0; num--)
		{
			char c = s[num];
			switch (c)
			{
			default:
				return c == '?';
			case '!':
			case '.':
				return true;
			case '\n':
			case ' ':
				break;
			}
		}
		return true;
	}

	private static string SetCapitalization(bool capitalize, string s)
	{
		if (string.IsNullOrEmpty(s))
		{
			return s;
		}
		if (capitalize)
		{
			return FirstLetterToUpper(s);
		}
		return FirstLetterToLower(s);
	}

	private static string FirstLetterToUpper(string s)
	{
		if (string.IsNullOrEmpty(s))
		{
			return s;
		}
		if (s.Length == 1)
		{
			return s.ToUpper();
		}
		return char.ToUpper(s[0]) + s.Substring(1);
	}

	private static string FirstLetterToLower(string s)
	{
		if (string.IsNullOrEmpty(s))
		{
			return s;
		}
		if (s.Length == 1)
		{
			return s.ToUpper();
		}
		return char.ToLower(s[0]) + s.Substring(1);
	}

	private static string ExtractVariableInputPrompt(ref string text)
	{
		string varName = string.Empty;
		if (text.Contains("[var=?"))
		{
			Regex regex = new Regex("\\[var=\\?.*\\]");
			int num = text.Length - 1;
			int num2 = 0;
			while (num >= 0 && num2 < 100)
			{
				num2++;
				int num3 = text.LastIndexOf("[var=?", num, StringComparison.OrdinalIgnoreCase);
				num = num3 - 1;
				if (num3 >= 0)
				{
					string text2 = text.Substring(0, num3);
					string input = text.Substring(num3);
					string text3 = regex.Replace(input, delegate(Match match)
					{
						varName = match.Value.Substring(6, match.Value.Length - 7).Trim();
						return string.Empty;
					});
					text = text2 + text3;
				}
			}
		}
		return varName;
	}

	private static bool ExtractTag(string tag, ref string text)
	{
		bool num = text.Contains(tag);
		if (num)
		{
			text = text.Replace(tag, string.Empty);
		}
		return num;
	}

	private static int ExtractPositionTag(ref string text)
	{
		int position = -1;
		if (text.Contains("[position "))
		{
			Regex regex = new Regex("\\[position\\s+[0-9]+\\]");
			text = regex.Replace(text, delegate(Match match)
			{
				int.TryParse(match.Value.Substring(10, match.Value.Length - 11), out position);
				return string.Empty;
			});
		}
		if (text.Contains("[position="))
		{
			Regex regex2 = new Regex("\\[position=[0-9]+\\]");
			text = regex2.Replace(text, delegate(Match match)
			{
				int.TryParse(match.Value.Substring(10, match.Value.Length - 11), out position);
				return string.Empty;
			});
		}
		return position;
	}

	private static int ExtractPanelNumberTag(ref string text)
	{
		int panelNumber = -1;
		if (text.Contains("[panel="))
		{
			Regex regex = new Regex("\\[panel=[0-9]+\\]");
			text = regex.Replace(text, delegate(Match match)
			{
				int.TryParse(match.Value.Substring(7, match.Value.Length - 8), out panelNumber);
				return string.Empty;
			});
		}
		return panelNumber;
	}

	private static int ExtractPicTag(string tagRegex, ref string text)
	{
		int index = 0;
		Regex regex = new Regex(tagRegex);
		text = regex.Replace(text, delegate(Match match)
		{
			int num = match.Value.IndexOf('=') + 1;
			string text2 = match.Value.Substring(num, match.Value.Length - (num + 1));
			if (!int.TryParse(text2, out index))
			{
				index = DialogueLua.GetVariable(text2).asInt;
			}
			return string.Empty;
		});
		return index;
	}

	private static Emphasis[] ExtractEmphasisTags(ref string text, EmphasisSetting[] emphasisSettings)
	{
		List<Emphasis> emphases = new List<Emphasis>();
		if (text.Contains("[em"))
		{
			Regex regex = new Regex("\\[\\/?em[1-" + emphasisSettings.Length + "]\\]");
			text = regex.Replace(text, delegate(Match match)
			{
				string s = match.Value.Substring(match.Value.Length - 2, 1);
				int result = 1;
				int.TryParse(s, out result);
				result--;
				if (emphasisSettings != null && 0 <= result && result < emphasisSettings.Length)
				{
					Emphasis item = new Emphasis(0, int.MaxValue, emphasisSettings[result].color, emphasisSettings[result].bold, emphasisSettings[result].italic, emphasisSettings[result].underline);
					emphases.Clear();
					emphases.Add(item);
				}
				return string.Empty;
			});
		}
		return emphases.ToArray();
	}

	private static Emphasis[] ReplaceEmphasisTagsWithRichText(ref string text, EmphasisSetting[] emphasisSettings)
	{
		if (text.Contains("[em"))
		{
			for (int i = 0; i < emphasisSettings.Length; i++)
			{
				string text2 = $"[em{i + 1}]";
				string oldValue = $"[/em{i + 1}]";
				if (text.Contains(text2))
				{
					string newValue = string.Format("{0}{1}<color={2}>", new object[3]
					{
						emphasisSettings[i].bold ? "<b>" : string.Empty,
						emphasisSettings[i].italic ? "<i>" : string.Empty,
						Tools.ToWebColor(emphasisSettings[i].color)
					});
					string newValue2 = string.Format("</color>{0}{1}", new object[2]
					{
						emphasisSettings[i].italic ? "</i>" : string.Empty,
						emphasisSettings[i].bold ? "</b>" : string.Empty
					});
					text = text.Replace(text2, newValue).Replace(oldValue, newValue2);
				}
			}
		}
		return new Emphasis[0];
	}

	public static FontStyle GetFontStyle(Emphasis emphasis)
	{
		if (emphasis.bold && emphasis.italic)
		{
			return FontStyle.BoldAndItalic;
		}
		if (emphasis.bold)
		{
			return FontStyle.Bold;
		}
		if (emphasis.italic)
		{
			return FontStyle.Italic;
		}
		return FontStyle.Normal;
	}
}
You are not using the latest version of the tool, please update.
Latest version is '11.1.0.9782' (yours is '9.1.0.7988')
