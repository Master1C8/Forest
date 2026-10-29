using System;
class Check {
    static bool CCSourcePathMatches(string actual,string source){
        if(actual==source)return true;
        const string prefix="LevelSingletons/";
        return source.StartsWith(prefix,System.StringComparison.Ordinal)&&
            actual==prefix+"LevelSingletons(Clone)/"+source.Substring(prefix.Length);
    }
static void Main(){
if(CCSourcePathMatches("LevelSingletons/Item Get Notification","LevelSingletons/Item Get Notification")!=true)throw new Exception("source-path-boundary");
if(CCSourcePathMatches("LevelSingletons/LevelSingletons(Clone)/Item Get Notification","LevelSingletons/Item Get Notification")!=true)throw new Exception("source-path-boundary");
if(CCSourcePathMatches("LevelSingletons/LevelSingletons(Clone)/ChapterSelectUI/ChapterSelectUI","LevelSingletons/ChapterSelectUI/ChapterSelectUI")!=true)throw new Exception("source-path-boundary");
if(CCSourcePathMatches("Other/Item Get Notification","LevelSingletons/Item Get Notification")!=false)throw new Exception("source-path-boundary");
if(CCSourcePathMatches("LevelSingletons/LevelSingletons(Clone)/LevelSingletons(Clone)/Item Get Notification","LevelSingletons/Item Get Notification")!=false)throw new Exception("source-path-boundary");
if(CCSourcePathMatches("LevelSingletons/Item Get Notification(Clone)","LevelSingletons/Item Get Notification")!=false)throw new Exception("source-path-boundary");
if(CCSourcePathMatches("Else/LevelSingletons(Clone)/Item Get Notification","LevelSingletons/Item Get Notification")!=false)throw new Exception("source-path-boundary");
Console.WriteLine("7 actual CSharp source-path predicates pass");
}}
