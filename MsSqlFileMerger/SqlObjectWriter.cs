using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Reflection.Emit;
using System.Text;
using System.Threading.Tasks;
using Microsoft.VisualStudio.TextTemplating;

namespace MsSqlFileMerger
{
    public class SqlObjectWriter
    {
        public TextTransformation Output;

        public string RowDelimiterDropCreate = $"{Environment.NewLine}/* ================================================================== */{Environment.NewLine}";
        public string RowDelimiterObject = $"{Environment.NewLine}/* ------------------------------------------------------------------ */{Environment.NewLine}";
        public bool IsWriteGenOrder = true;
        public bool IsWriteFileName = true;

        public string SolutionDir;

        public void WriteLine(string line)
        {
            if (Output != null)
                Output.WriteLine(line);
            else
                Trace.TraceInformation(line);

        }

        public void Write(string line)
        {
            if (Output != null)
                Output.Write(line);
            else
                Trace.TraceInformation(line);
        }

        public void WriteUseDb(string dbName)
        {
            WriteLine($"use {dbName}");
            WriteLine($"go");
            WriteLine($"");
        }

        public void WriteSqlScript(List<SqlObject> sqlObjectList)
        {
            foreach (var obj in sqlObjectList.OrderByDescending(c => c.CreateOrder))
            {
                if (IsWriteGenOrder) WriteLine($"-- create order {obj.CreateOrder}");
                switch (obj.ObjectType)
                {
                    case SqlObjectTypeEnum.Procedure:
                        WriteLine($"if exists(select 1 from sysobjects where id = object_id('{obj.Schema}.{obj.Name}')and type in ('P', 'PC'))");
                        WriteLine($"    drop procedure {obj.Schema}.{obj.Name}");
                        WriteLine($"go");
                        break;
                    case SqlObjectTypeEnum.Proc:
                        WriteLine($"if exists(select 1 from sysobjects where id = object_id('{obj.Schema}.{obj.Name}')and type in ('P', 'PC'))");
                        WriteLine($"    drop procedure {obj.Schema}.{obj.Name}");
                        WriteLine($"go");
                        break;
                    case SqlObjectTypeEnum.Function:
                        WriteLine($"if exists(select 1 from sysobjects where id = object_id('{obj.Schema}.{obj.Name}')and type in ('IF', 'FN', 'TF'))");
                        WriteLine($"    drop function {obj.Schema}.{obj.Name}");
                        WriteLine($"go");
                        break;
                    case SqlObjectTypeEnum.Table:
                        WriteLine($"if exists(select 1 from information_schema.tables where table_name = '{obj.Name}'  and table_schema = '{obj.Schema}')");
                        WriteLine($"    drop table {obj.Schema}.{obj.Name}");
                        WriteLine($"go");
                        break;
                    case SqlObjectTypeEnum.View:
                        //if exists (select 1 from  sysobjects where  id = object_id('nav.vPassRecStartFinish') and   type = 'V') drop view nav.vPassRecStartFinish
                        WriteLine($"if exists(select 1 from sysobjects where id = object_id('{obj.Schema}.{obj.Name}')and type = 'V')");
                        WriteLine($"    drop view {obj.Schema}.{obj.Name}");
                        WriteLine($"go");
                        break;
                }
                WriteLine($"");
            }

            WriteLine(RowDelimiterDropCreate);

            foreach (var obj in sqlObjectList.OrderBy(c => c.CreateOrder))
            {
                WriteLine(RowDelimiterObject);

                var fileNameForWrite = obj.SqlSourceFile;
                ClearFileName(SolutionDir, ref fileNameForWrite);

                if (IsWriteFileName) WriteLine($"-- source file {fileNameForWrite}");
                if (IsWriteGenOrder) WriteLine($"-- generate order {obj.CreateOrder}");

                WriteLine($"go{Environment.NewLine}{obj.ObjectBody}");

                if (!obj.ObjectBody.ToLower().EndsWith("go"))
                    WriteLine($"go");

                WriteLine($"");
            }

        }

        public static void ClearFileName(string solutionPath, ref string sqlSourceFileName)
        {
            if (string.IsNullOrEmpty(solutionPath))
                return;

            var dir = new DirectoryInfo(solutionPath);
            var a = sqlSourceFileName.Replace(solutionPath, "");
            var b = Path.Combine(dir.Name, a);

            sqlSourceFileName = $"..\\{b}";
        }
    }
}
