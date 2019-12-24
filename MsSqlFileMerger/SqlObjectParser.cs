using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MsSqlFileMerger
{
    internal class SqlObjectParser
    {
        public List<SqlObject> ParseStrArray(ref string[] lines, ref int createOrderCounter, string sqlSourceFile, bool isSpToEndFile)
        {
            var result = new List<SqlObject>();
            var i = 0;

            for (i = 0; i < lines.Length; i++)
            {
                var line = lines[i];

                if (string.IsNullOrEmpty(line?.Trim()))
                    continue;

                var list = ExtractSqlObject(ref lines, ref i, ref createOrderCounter, sqlSourceFile, isSpToEndFile);

                foreach (var item in list)
                    result.Add(item);

            }

            return result;
        }


        private List<SqlObject> ExtractSqlObject(ref string[] lines, ref int startLineNum, ref int createOrderCounter, string sqlSourceFile, bool isToEndFile)
        {
            var result = new List<SqlObject>();

            var startObjectLineIdx = 0;
            var objectType = "";
            var objectSchema = "";
            var objectName = "";

            var s = lines.ExtractObjectInfo(ref startLineNum, ref startObjectLineIdx, ref objectType, ref objectSchema, ref objectName);

            while (!string.IsNullOrWhiteSpace(objectName) && !string.IsNullOrWhiteSpace(objectType))
            {

                var obj = new SqlObject();
                if (!Enum.TryParse(objectType, true, out SqlObjectTypeEnum a)) continue;

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
                    case SqlObjectTypeEnum.Function:
                        ExtractSqlSp(ref lines, ref startLineNum, obj, isToEndFile);
                        break;
                }

                objectType = "";
                objectSchema = "";
                objectName = "";

                s = lines.ExtractObjectInfo(ref startLineNum, ref startObjectLineIdx, ref objectType, ref objectSchema, ref objectName);

            }

            return result;
        }

        //public static SqlObject ParseObjectHeader(string line, ref int createOrderCounter, string sqlSourceFile = null)
        //{
        //    var newObj = new SqlObject();
        //    newObj.ObjectType = SqlObjectTypeEnum.No;

        //    if (line.ToLower().Contains("create procedure")) newObj.ObjectType = SqlObjectTypeEnum.Procedure;
        //    if (line.ToLower().Contains("create function")) newObj.ObjectType = SqlObjectTypeEnum.Function;
        //    if (line.ToLower().Contains("create table")) newObj.ObjectType = SqlObjectTypeEnum.Table;
        //    if (line.ToLower().Contains("create view")) newObj.ObjectType = SqlObjectTypeEnum.View;
        //    newObj.ParseName(line);
        //    newObj.CreateOrder = createOrderCounter++;
        //    newObj.SqlSourceFile = sqlSourceFile;

        //    if (newObj.ObjectType == SqlObjectTypeEnum.No)
        //        return null;

        //    return newObj;
        //}

        private void ExtractSqlSp(ref string[] lines, ref int startLineNum, SqlObject sqlObject, bool isSpToEndFile)
        {
            var beginNested = 0;
            var firstBeginIdx = 0;
            var endIdx = 0;
            var idx = 0;
            // var body = "";


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
                var line = lines[idx];

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

                var wordListInLine = line.ToLower().Split(' ', ',', '.', ';').ToList();

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



                //lineArr = line.ToLower().Split(' ');

                //if (line == "end")
                if (!isSpToEndFile)
                {
                    //if (wordListInLine.Contains("end"))
                    //{
                    //    beginNested--;
                    //    if (beginNested == 0)
                    //        endIdx = idx;

                    //}

                    while (wordListInLine.Contains("end"))
                    {
                        beginNested--;
                        if (beginNested == 0)
                            endIdx = idx;

                        var xIdx = wordListInLine.IndexOf("end");

                        wordListInLine.RemoveAt(xIdx);
                    }

                    if (line == "go")
                    {
                        beginNested--;
                        if (beginNested == 0)
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
                if (line == "go" && !isToEndFile)
                    break;

                var endOfLine = (idx < lines.Length - 1) ? Environment.NewLine : "";

                sqlObject.ObjectBody += $"{lines[idx]}{endOfLine}";


            }// for

            startLineNum = idx;
        }
    }
}
