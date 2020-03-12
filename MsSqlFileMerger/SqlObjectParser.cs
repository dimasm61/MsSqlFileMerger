using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.VisualStudio.TextTemplating;

namespace MsSqlFileMerger
{
    /// <summary>
    /// SQL script parser
    /// </summary>
    public class SqlObjectParser
    {
        public List<SqlObject> ParseStrArray(TextTransformation output, ref string[] lines, ref int createOrderCounter, string sqlSourceFile, bool isToEndFile)
        {
            var result = new List<SqlObject>();
            var i = 0;

            for (i = 0; i < lines.Length; i++)
            {
                var line = lines[i];

                if (string.IsNullOrEmpty(line?.Trim()))
                    continue;

                // as processing i iterator will changed
                var list = ExtractSqlObject(output, ref lines, ref i, ref createOrderCounter, sqlSourceFile, isToEndFile);

                foreach (var item in list)
                    result.Add(item);

            }

            return result;
        }


        private List<SqlObject> ExtractSqlObject(TextTransformation output, ref string[] lines, ref int startLineNum, ref int createOrderCounter, string sqlSourceFile, bool isToEndFile)
        {
            var result = new List<SqlObject>();

            var startObjectLineIdx = startLineNum;
            var objectType = "";
            var objectSchema = "";
            var objectName = "";

            var maxStepCounter = 0;

            var s = lines.ExtractObjectInfo(ref startLineNum, ref startObjectLineIdx, ref objectType, ref objectSchema, ref objectName);

            while (!string.IsNullOrWhiteSpace(objectName) && !string.IsNullOrWhiteSpace(objectType) & maxStepCounter++ < 1000)
            {

                var obj = new SqlObject();

                if (!Enum.TryParse(objectType, true, out SqlObjectTypeEnum a))
                {
                    // if parse is fail, log info and move to next "GO"

                    if (output != null)
                    {
                        output.WriteLine($"-- couldn't extract sql object type, schema, and name");
                        output.WriteLine($"-- something wrong in header string '{s}'");
                    }
                    else
                    {
                        Trace.TraceWarning($"-- couldn't extract sql object type, schema, and name");
                        Trace.TraceWarning($"-- something wrong in header string '{s}'");
                    }

                    // something in header fail
                    // try move to next GO
                    for (var i = startLineNum; i < lines.Length; i++)
                    {
                        startLineNum = i;

                        if (lines[i].Trim(' ').ToLower().StartsWith("go"))
                            break;
                    }
                    break;
                }

                obj.ObjectType = a;
                obj.Schema = objectSchema;
                obj.Name = objectName;
                obj.CreateOrder = createOrderCounter++;
                obj.SqlSourceFile = sqlSourceFile;
                result.Add(obj);
                startLineNum = startObjectLineIdx;
                switch (obj.ObjectType)
                {
                    case SqlObjectTypeEnum.No:
                        break;
                    case SqlObjectTypeEnum.Table:
                        ExtractSqlTable(ref lines, ref startLineNum, obj, isToEndFile);
                        break;
                    case SqlObjectTypeEnum.View:
                        ExtractSqlViewBody(ref lines, ref startLineNum, obj, isToEndFile);
                        break;
                    case SqlObjectTypeEnum.Procedure:
                        ExtractSqlSp(ref lines, ref startLineNum, obj, isToEndFile);
                        break;
                    case SqlObjectTypeEnum.Proc:
                        ExtractSqlSp(ref lines, ref startLineNum, obj, isToEndFile);
                        break;
                    case SqlObjectTypeEnum.Function:
                        ExtractSqlSp(ref lines, ref startLineNum, obj, isToEndFile);
                        break;
                    case SqlObjectTypeEnum.Trigger:
                        ExtractSqlSp(ref lines, ref startLineNum, obj, false);
                        break;
                }

                objectType = "";
                objectSchema = "";
                objectName = "";

                s = lines.ExtractObjectInfo(ref startLineNum, ref startObjectLineIdx, ref objectType, ref objectSchema, ref objectName);

            }

            return result;
        }

        private void ExtractSqlSp(ref string[] lines, ref int startLineNum, SqlObject sqlObject, bool isSpToEndFile)
        {
            var beginNested = 0;
            var firstBeginIdx = 0;
            var endIdx = 0;
            var idx = 0;

            var func = new Func<string, bool>((line) =>
            {
                var ignoreCommand = new[] { "end conversation", "begin conversation", "begin transaction" };
                foreach (var cmd in ignoreCommand)
                {
                    if (line.Contains(cmd))
                        return true;
                }
                return false;
            });

            for (idx = startLineNum; idx < lines.Length; idx++)
            {
                var line = lines[idx].ToLower();

                while (line?.Contains("  ") == true) line = line?.Replace("  ", " ")?.Trim();

                if (string.IsNullOrEmpty(line?.Trim()))
                {
                    sqlObject.ObjectBody += $"{lines[idx]}{Environment.NewLine}";
                    continue;
                }

                if (func(line))
                {
                    sqlObject.ObjectBody += $"{lines[idx]}{Environment.NewLine}";
                    continue;
                }

                var wordListInLine = line.Split(' ', ',', '.', ';', '\t').ToList();

                while (wordListInLine.Contains("begin"))
                {
                    if (firstBeginIdx == 0)
                        firstBeginIdx = idx;
                    beginNested++;

                    var xIdx = wordListInLine.IndexOf("begin");

                    wordListInLine.RemoveAt(xIdx);
                }


                while (wordListInLine.Contains("case"))
                {
                    if (firstBeginIdx == 0)
                        firstBeginIdx = idx;
                    beginNested++;

                    var xIdx = wordListInLine.IndexOf("case");

                    wordListInLine.RemoveAt(xIdx);
                }


                while (wordListInLine.Contains("end"))
                {
                    beginNested--;
                    // if (beginNested == 0)
                    //     endIdx = idx;

                    var xIdx = wordListInLine.IndexOf("end");

                    wordListInLine.RemoveAt(xIdx);
                }

                if (!isSpToEndFile)
                {

                    if (line.ToLower() == "go")
                    {
                        //beginNested--;
                        //if (beginNested == 0)
                            endIdx = idx;

                    }
                }

                var endOfLine = (idx < lines.Length - 1) ? Environment.NewLine : "";

                sqlObject.ObjectBody += $"{lines[idx]}{endOfLine}";

                if (endIdx != 0)
                {
                    startLineNum = idx;
                    break;
                }

            }// for
            startLineNum = idx;
        }

        private void ExtractSqlTable(ref string[] lines, ref int startLineNum, SqlObject sqlObject, bool isToEndFile)
        {
            var idx = 0;

            for (idx = startLineNum; idx < lines.Length; idx++)
            {
                var line = lines[idx];

                while (line?.Contains("  ") == true) line = line?.Replace("  ", " ")?.Trim();

                if (string.IsNullOrEmpty(line?.Trim()))
                {
                    sqlObject.ObjectBody += $"{lines[idx]}{Environment.NewLine}";
                    continue;
                }


                if (line.ToLower() == "go" && !isToEndFile)
                {
                    break;
                }

                var endOfLine = (idx < lines.Length - 1) ? Environment.NewLine : "";

                sqlObject.ObjectBody += $"{lines[idx]}{endOfLine}";

            }// for

            startLineNum = idx;
        }


        private void ExtractSqlViewBody(ref string[] lines, ref int startLineNum, SqlObject sqlObject, bool isToEndFile)
        {
            var idx = 0;

            for (idx = startLineNum; idx < lines.Length; idx++)
            {
                var line = lines[idx];

                while (line?.Contains("  ") == true) line = line?.Replace("  ", " ")?.Trim();

                if (string.IsNullOrEmpty(line?.Trim()))
                {
                    sqlObject.ObjectBody += $"{lines[idx]}{Environment.NewLine}";
                    continue;
                }

                // Конец таблиц считаем по GO
                if (line.ToLower() == "go" && !isToEndFile)
                    break;

                var endOfLine = (idx < lines.Length - 1) ? Environment.NewLine : "";

                sqlObject.ObjectBody += $"{lines[idx]}{endOfLine}";


            }// for

            startLineNum = idx;
        }
    }
}
