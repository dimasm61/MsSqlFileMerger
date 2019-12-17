using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.VisualStudio.TextTemplating;

namespace MsSqlFileMerger
{
    public class SqlFileMergeHelper
    {
        private List<SqlObject> _sqlObjectList = new List<SqlObject>();

        public TextTransformation Output;

        private void WriteLine(string line)
        {
            if (Output != null)
                Output.WriteLine(line);
            else
                Trace.WriteLine(line);
        }

        private void Write(string line)
        {
            if (Output != null)
                Output.Write(line);
            else
                Trace.WriteLine(line);
        }

        public void Load(string baseName, string rootPath, Encoding encoding, string[] sqlFolders, bool isSpToEndFile)
        {
            _sqlObjectList.Clear();
            var readedFiles = new List<string>();
            var createOrderCounter = 0;
            // читаем даннные в память
            foreach (var sqlFolder in sqlFolders)
            {
                var folder = Path.Combine(rootPath, sqlFolder);
                var files = Directory.GetFiles(folder, "*.sql", SearchOption.TopDirectoryOnly);
                foreach (var sqlFile in files)
                {
                    // WriteLine($"-- {sqlFile}");

                    if (!string.IsNullOrEmpty(sqlFile) && sqlFile.ToLower().Contains("ignore"))
                        continue;

                    var txt = File.ReadAllLines(sqlFile, encoding);
                    if (txt.Length > 0 && txt[0].StartsWith("T4_IGNORE"))
                        return;

                    ParseFile(ref txt, ref createOrderCounter, sqlFile, isSpToEndFile);

                    readedFiles.Add(sqlFile);

                }//foreach( var sqlFile in files)
            }//foreach(var sqlFolder in sqlFolders)

            // foreach (var item in sqlObjectList)
            // {
            //     WriteLine($"//{item.CreateOrder:00} - {item.ObjectType} - {item.Schema}.{item.Name}");
            // }
        }

        private void ParseFile(ref string[] lines, ref int createOrderCounter, string sqlSourceFile, bool isSpToEndFile)
        {
            var i = 0;

            for (i = 0; i < lines.Length; i++)
            {
                var line = lines[i];

                if (string.IsNullOrEmpty(line?.Trim()))
                    continue;

                if (line.ToLower().Contains("create"))
                {
                    // начало какого-то объекта
                    // конец = end или go
                    ExtractSqlObject(ref lines, ref i, ref createOrderCounter, sqlSourceFile, isSpToEndFile);
                }
            }
        }


        private void ExtractSqlObject(ref string[] lines, ref int startLineNum, ref int createOrderCounter, string sqlSourceFile, bool isSpToEndFile)
        {
            var s = lines[startLineNum];

            while (s.Contains("  ")) s = s.Replace("  ", " ");

            if (s.ToLower().Contains("create procedure"))
            {
                var newObj = new SqlObject();
                newObj.ObjectType = "proc";
                newObj.ParseName(s);
                newObj.CreateOrder = createOrderCounter++;
                newObj.SqlSourceFile = sqlSourceFile;
                _sqlObjectList.Add(newObj);

                ExtractSqlSp(ref lines, ref startLineNum, newObj, isSpToEndFile);
            }


            if (s.ToLower().Contains("create function"))
            {
                var newObj = new SqlObject();
                newObj.ObjectType = "func";
                newObj.ParseName(s);
                newObj.CreateOrder = createOrderCounter++;
                newObj.SqlSourceFile = sqlSourceFile;
                _sqlObjectList.Add(newObj);

                ExtractSqlSp(ref lines, ref startLineNum, newObj, isSpToEndFile);
            }

            if (s.ToLower().Contains("create table"))
            {
                var newObj = new SqlObject();
                newObj.ObjectType = "table";
                newObj.ParseName(s);
                newObj.CreateOrder = createOrderCounter++;
                newObj.SqlSourceFile = sqlSourceFile;
                _sqlObjectList.Add(newObj);

                ExtractSqlTable(ref lines, ref startLineNum, newObj);
            }

            if (s.ToLower().Contains("create view"))
            {
                var newObj = new SqlObject();
                newObj.ObjectType = "view";
                newObj.ParseName(s);
                newObj.CreateOrder = createOrderCounter++;
                newObj.SqlSourceFile = sqlSourceFile;
                _sqlObjectList.Add(newObj);

                ExtractSqlTable(ref lines, ref startLineNum, newObj);
            }
        }

        private void ExtractSqlSp(ref string[] lines, ref int startLineNum, SqlObject sqlObject, bool isSpToEndFile)
        {
            var beginNested = 0;
            var firstBeginIdx = 0;
            var endIdx = 0;
            var idx = 0;
            // var body = "";


            var func = new Func<string, bool>((line) => {
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

                line = ClearLineForAnalyze(line);

                if (func(line))
                {
                    sqlObject.ObjectBody += $"{lines[idx]}{Environment.NewLine}";
                    continue;
                }

                var wordListInLine = line.ToLower().Split(' ',',','.').ToList();
                // if (wordListInLine.Contains("begin") || wordListInLine.Contains("case"))
                // {
                //     if (firstBeginIdx == 0)
                //         firstBeginIdx = idx;
                //     beginNested++;
                // }

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
                sqlObject.ObjectBody += $"{lines[idx]}{Environment.NewLine}";

                if (endIdx != 0)
                {
                    startLineNum = idx;
                    break;
                }

            }// for

        }

        private void ExtractSqlTable(ref string[] lines, ref int startLineNum, SqlObject sqlObject)
        {
            for (var idx = startLineNum; idx < lines.Length; idx++)
            {
                var line = lines[idx];

                while (line?.Contains("  ") == true) line = line?.Replace("  ", " ")?.Trim();

                line = ClearLineForAnalyze(line);

                // if (line.Contains("--"))
                // {
                //     var commentPos = line.IndexOf("--");
                //     line = line.Remove(commentPos, line.Length - commentPos);
                // }

                if (string.IsNullOrEmpty(line?.Trim()))
                {
                    sqlObject.ObjectBody += $"{lines[idx]}{Environment.NewLine}";
                    continue;
                }

                // Конец таблиц считаем по GO
                if (line == "go")
                {
                    startLineNum = idx;
                    break;
                }

                sqlObject.ObjectBody += $"{lines[idx]}{Environment.NewLine}";
            }// for

        }


        public void WriteSqlScript()
        {
            foreach (var obj in _sqlObjectList.OrderByDescending(c => c.CreateOrder))
            {
                WriteLine($"-- create order {obj.CreateOrder}");
                switch (obj.ObjectType)
                {
                    case "proc":
                        WriteLine($"if exists(select 1 from sysobjects where id = object_id('{obj.Schema}.{obj.Name}')and type in ('P', 'PC'))");
                        WriteLine($"    drop procedure {obj.Schema}.{obj.Name}");
                        WriteLine($"go");
                        break;
                    case "func":
                        // if exists (select 1 from sysobjects where  id = object_id('nav.fnGetPassTypeCode') and type in ('IF', 'FN', 'TF')) drop function nav.fnGetPassTypeCode
                        WriteLine($"if exists(select 1 from sysobjects where id = object_id('{obj.Schema}.{obj.Name}')and type in ('IF', 'FN', 'TF'))");
                        WriteLine($"    drop function {obj.Schema}.{obj.Name}");
                        WriteLine($"go");
                        break;
                    case "table":
                        WriteLine($"if exists(select 1 from information_schema.tables where table_name = '{obj.Name}'  and table_schema = '{obj.Schema}')");
                        WriteLine($"    drop table {obj.Schema}.{obj.Name}");
                        WriteLine($"go");
                        break;
                    case "view":
                        //if exists (select 1 from  sysobjects where  id = object_id('nav.vPassRecStartFinish') and   type = 'V') drop view nav.vPassRecStartFinish
                        WriteLine($"if exists(select 1 from sysobjects where id = object_id('{obj.Schema}.{obj.Name}')and type = 'V')");
                        WriteLine($"    drop view {obj.Schema}.{obj.Name}");
                        WriteLine($"go");
                        break;
                }
                WriteLine($"");
            }

            WriteLine($"--------------------------------------------------------");

            foreach (var obj in _sqlObjectList.OrderBy(c => c.CreateOrder))
            {
                WriteLine($"-- source file {obj.SqlSourceFile}");
                WriteLine($"-- create order {obj.CreateOrder}");
                Write($"go{Environment.NewLine}{obj.ObjectBody}");
                WriteLine($"go");
                WriteLine($"");
            }

        }

        private static string ClearLineForAnalyze(string line)
        {
            if (line.Contains("--"))
            {
                var commentPos = line.IndexOf("--");
                line = line.Remove(commentPos, line.Length - commentPos);
            }

            // если есть SQL строка
            if (line.Contains("'"))
            {
                var idx1 = line.IndexOf('\'');
                var idx2 = line.IndexOf('\'', idx1 + 1);

                if (idx1 > 0 && idx2 > idx1)
                    line = line.Remove(idx1 + 1, idx2 - idx1 - 1);
            }

            return line;
        }
    }
}
