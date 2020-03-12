using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace MsSqlFileMerger
{
    internal static class SqlObjectParserInfo
    {
        public static string ExtractObjectInfo(this string[] lines, ref int lineIndex, ref int startObjectLineIdx, ref string objectType, ref string objectSchema, ref string objectName)
        {
            if (lineIndex >= lines.Length - 1)
                return "";

            var sb = new StringBuilder(1000);

            var maxStepCounter = 0;

            var commentDepth = 0;
            var doWork = true;
            var idx = 0;
            var line = lines[lineIndex];
            startObjectLineIdx = lineIndex;

            //                  idx    i-1,  i , i+1
            var movingWindow = new[] { ' ', ' ', ' ', };
            var prevSavedChar = ' ';

            // get string after 'start' file or 'go' word,
            // up to 'as' with removing comments

            while (doWork & maxStepCounter++ < 1000000)
            {
                if (string.IsNullOrWhiteSpace(line))
                {
                    sb.Append(" ");
                    MoveNextLine(ref doWork, ref lines, ref lineIndex, ref line, ref idx, ref sb);
                    continue;
                }

                movingWindow[0] = idx > 0 ? line[idx - 1] : ' ';
                movingWindow[1] = line[idx];
                movingWindow[2] = idx < line.Length - 1 ? line[idx + 1] : ' ';

                // check for start or finish multiline comment
                if (movingWindow.ContainsAny('*', '/') && idx <= (line.Length - 2))
                {
                    if (movingWindow.MatchEnds("?/*"))
                    {
                        // if start comment detected
                        commentDepth++;
                        idx += 1;
                        //move to next symbol in line
                        MoveNextSymbol(ref doWork, ref lines, ref lineIndex, ref line, ref idx, ref sb);
                        continue;
                    }

                    if (movingWindow.MatchEnds("?*/"))
                    {
                        // if start comment detected
                        commentDepth--;
                        idx += 1;
                        //move to next symbol in line
                        MoveNextSymbol(ref doWork, ref lines, ref lineIndex, ref line, ref idx, ref sb);
                        continue;
                    }
                }

                // if single line comment start
                // move to next line
                if (commentDepth == 0 && movingWindow.MatchEnds("--") && idx <= (line.Length - 2))
                {
                    MoveNextLine(ref doWork, ref lines, ref lineIndex, ref line, ref idx, ref sb);
                    continue;
                }

                // if is not comment append result
                if (doWork && commentDepth == 0)
                {
                    // filtering double space char and brackets
                    if (!(prevSavedChar == ' ' && movingWindow[1] == ' ') && movingWindow[1] != '[' && movingWindow[1] != ']')
                    {
                        if (idx == 0 && prevSavedChar != ' ' && movingWindow[1] != ' ')
                            sb.Append(' ');


                        sb.Append(movingWindow[1]);
                        prevSavedChar = movingWindow[1];
                    }

                    // if GO = then new line
                    if (sb.CompareLastAddedSentence("go"/*,' ','-','/'*/)
                        || line.Trim().ToLower() == "go")
                    {
                        sb.Clear();
                        startObjectLineIdx = lineIndex + 1;
                        MoveNextLine(ref doWork, ref lines, ref lineIndex, ref line, ref idx, ref sb);
                        continue;
                    }

                    // if find ' as ' - finish
                    // doWork = !(sb.CompareLastAddedSentence("as")
                    //     || sb.CompareLastAddedSentence(@"\("));
                    doWork = !IsHaveObjectDefinition(sb);
                }

                MoveNextSymbol(ref doWork, ref lines, ref lineIndex, ref line, ref idx, ref sb);


            }// while do work

            var str = sb.ToString();

            // extract object type and name using regex
            //var regex = new Regex(@"(create|alter)(\s*)(procedure|proc|table|trigger|view|function)(\s*)((\s[a-z]*[.])|\s)([a-zA-Z0-9]*)(.*)as", RegexOptions.IgnoreCase);
            var regex = new Regex(@"((\s|[-]|[\/]|(?<=\ |^))((create|alter)[\s]*))((procedure|proc|procc|table|trigger|view|function)[\s])[\s]*(([a-zA-Z0-9^.]*[.][.][a-zA-z0-9^.]*)|([a-zA-Z0-9^.]*[.][a-zA-z0-9^.]*[.][a-zA-z0-9^.]*)|([a-zA-z0-9^.]*[.][a-zA-z0-9^.]*)|([a-zA-Z0-9^.]*))([a-zA-Z0-9]*)(.*)((as|\()(\s|[-]|\/)|(\())", RegexOptions.IgnoreCase);

            var match = regex.Match(str);

            if (match.Success)
            {
                var opertr = match.Groups[1].Value.Trim();

                objectType = match.Groups[5].Value.Trim(' ');

                var objFullName = match.Groups[7].Value.Trim();

                // create view View1
                if (new Regex(regexPattern1).Match(objFullName) is Match m1 && m1.Success)
                {
                    objectSchema = "dbo";
                    objectName = m1.Groups[1].Value;
                }

                // create view dbo.View1
                if (new Regex(regexPattern2).Match(objFullName) is Match m2 && m2.Success)
                {
                    objectSchema = m2.Groups[1].Value;
                    objectName = m2.Groups[2].Value;
                }

                // create view db1..View1
                if (new Regex(regexPattern3).Match(objFullName) is Match m3 && m3.Success)
                {
                    objectSchema = "dbo";
                    objectName = m3.Groups[2].Value;
                }

                // create view db1.dbo.View1
                if (new Regex(regexPattern4).Match(objFullName) is Match m4 && m4.Success)
                {
                    objectSchema = m4.Groups[2].Value;
                    objectName = m4.Groups[3].Value;
                }

            }

            return str;
        }

        private static string regexPattern1 = @"(?<=\ |^)([a-zA-Z0-9][^\.]+)(?=\ |$)";
        private static string regexPattern2 = @"(?<=\ |^)([a-zA-Z0-9][^\.]+)[.]([a-zA-Z0-9][^\.]+)(?=\ |$)";
        private static string regexPattern3 = @"(?<=\ |^)([a-zA-Z0-9^.]+)[.][.]([a-zA-Z0-9^.]+)(?=\ |$)";
        private static string regexPattern4 = @"(?<=\ |^)([a-zA-Z0-9^.]+)[.]([a-zA-Z0-9^.]+)[.]([a-zA-Z0-9^.]+)(?=\ |$)";


        private static void MoveNextSymbol(ref bool doWork, ref string[] lines, ref int lineIdx, ref string line, ref int idx, ref StringBuilder sb)
        {
            if (!doWork)
                return;

            if (idx < line.Length - 1)
            {
                // move to next char
                idx++;
            }
            else
            {
                // if is end of line - move to next line
                if (lineIdx < lines.Length /*- 1*/)
                {
                    lineIdx++;
                    //line = lines[lineIdx];
                    //idx = 0;
                    //sb.Append(" ");
                }

                doWork = lineIdx < lines.Length/* - 1*/;

                if (doWork)
                {
                    line = lines[lineIdx];
                    idx = 0;
                }
            }

        }



        private static void MoveNextLine(ref bool doWork, ref string[] lines, ref int lineIdx, ref string line, ref int idx, ref StringBuilder sb)
        {
            if (!doWork)
                return;

            if (lineIdx < lines.Length/* - 1*/)
            {
                lineIdx++;
                //line = lines[lineIdx];
                //idx = 0;
                //sb.Append(" ");
            }

            doWork = lineIdx < lines.Length/* - 1*/;

            if (doWork)
            {
                line = lines[lineIdx];
                idx = 0;
            }
        }

        /// <summary>
        /// ? - any symbol
        /// </summary>
        /// <param name="baseCharArray"></param>
        /// <param name="str"></param>
        /// <returns></returns>
        public static bool MatchEnds(this char[] baseCharArray, string str)
        {
            if (str.Length == 0) return false;
            if (baseCharArray.Length == 0) return false;

            var result = true;

            var i = baseCharArray.Length - 1;
            var j = str.Length - 1;

            while (i >= 0 && j >= 0)
            {
                result = result && (baseCharArray[i] == str[j] || str[j] == '?');
                i--;
                j--;
            }

            return result;
        }

        public static bool ContainsAny(this char[] baseCharArray, params char[] symbols)
        {
            var result = false;

            foreach (var c in symbols)
                result = result || baseCharArray.Contains(c);

            return result;
        }

        public static bool CompareLastAddedSentence(this StringBuilder sb, string compareWord/*, params char[] endings*/)
        {
            if (sb.Length == 0)
                return false;

            if (sb.Length < 2 || compareWord.Length < 2)
                return false;

            var expression = $@"(\s|){compareWord}(\s|[-]|\/)";

            var regex = new Regex(expression, RegexOptions.IgnoreCase);

            var match = regex.Match(sb.ToString());

            return match.Success;

        }

        private static bool IsHaveObjectDefinition(this StringBuilder sb)
        {
            

            if (sb.Length < 20)
                return false;

            var str = sb.ToString();

            if (!((str.Contains("create") || str.Contains("alter")) && (str.Contains(" as") || str.Contains("("))))
            {
                return false;
            }

            var regex = new Regex(@"((\s|[-]|[\/]|(?<=\ |^))((create|alter)[\s]*))((procedure|proc|procc|table|trigger|view|function)[\s])[\s]*(([a-zA-Z0-9^.]*[.][.][a-zA-z0-9^.]*)|([a-zA-Z0-9^.]*[.][a-zA-z0-9^.]*[.][a-zA-z0-9^.]*)|([a-zA-z0-9^.]*[.][a-zA-z0-9^.]*)|([a-zA-Z0-9^.]*))([a-zA-Z0-9]*)(.*)((as|\()(\s|[-]|\/)|(\())", RegexOptions.IgnoreCase);

            var match = regex.Match(str);

            return match.Success;
        }

    }
}
