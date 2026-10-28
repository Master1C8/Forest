Read this brief and dispatch.json first. Fresh no-history gpt-6.1-sol/high/OpenAI.
You are the initial reviewer of 935 Russian existing-supplement935
IDs. Independent-diff means all935 newly admitted inputs form the exact
initial-delivery delta; review all of them independently. No inherited history,
other reviewers' decisions or nested jobs. Current input/context pins were checked.
Before any localization text, read /Users/antonkrutov/Desktop/Forest/outputs/ru-ui935-review-20261029/initial-02/review/runtime-verification.json and
verify actual model/reasoning/provider/fresh exec. Allow up to30 seconds only for
this receipt, then stop if absent/mismatched. Record runtime-check.json.
Read universal documents, contract, COMPLETE source/Russian glossaries and full
assigned consumer/context exactly once with:
python3 -B /Users/antonkrutov/Desktop/Forest/outputs/ru-ui935-review-20261029/initial-02/execution/editorial_lane.py bootstrap --job /Users/antonkrutov/Desktop/Forest/outputs/ru-ui935-review-20261029/initial-02 --start 0
Follow returned next until next==length; max_output_tokens12000. Never credit
truncated output. Additional mandatory references apply if not already emitted.
Read every source/target/context row using:
python3 -B /Users/antonkrutov/Desktop/Forest/outputs/ru-ui935-review-20261029/initial-02/execution/editorial_lane.py read --phase /Users/antonkrutov/Desktop/Forest/outputs/ru-ui935-review-20261029/initial-02/review --start 0 --count 8
Follow next through the entire packet. Use read-unit for any oversized record.
For each read chunk, author explicit individual decisions in your own reasoning,
then store a JSON list via stdin to:
python3 -B /Users/antonkrutov/Desktop/Forest/outputs/ru-ui935-review-20261029/initial-02/execution/editorial_lane.py record --phase /Users/antonkrutov/Desktop/Forest/outputs/ru-ui935-review-20261029/initial-02/review
Fields: id, verdict(pass|finding|needs-context|source-defect|technical-preservation),
rationale; findings also require full proposedTarget or requiresSourceDecision=true.
Scripts may serialize/store your explicit rows, never generate judgments or fill
unread IDs. Collect all findings. After genuine complete review call once:
python3 -B /Users/antonkrutov/Desktop/Forest/outputs/ru-ui935-review-20261029/initial-02/execution/editorial_lane.py finalize --phase /Users/antonkrutov/Desktop/Forest/outputs/ru-ui935-review-20261029/initial-02/review
Finish with concise result. No history/process/environment searches or self token
accounting. Write only phase receipts/decisions/result; targets/context read-only.
