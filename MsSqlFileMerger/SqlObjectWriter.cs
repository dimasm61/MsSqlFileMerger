using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.VisualStudio.TextTemplating;

namespace MsSqlFileMerger
{
    internal class SqlObjectWriter
    {
        public TextTransformation Output;

        private void WriteLine(string line)
        {
            if (Output != null)
                Output.WriteLine(line);
            else
                Console.WriteLine(line);
        }

        private void Write(string line)
        {
            if (Output != null)
                Output.Write(line);
            else
                Console.WriteLine(line);
        }

        public void WriteUseDb(string dbName)
        {
            WriteLine($"use {dbName};");
            WriteLine($"go;");
            WriteLine($"");
        }

        public void WriteSqlScript(List<SqlObject> sqlObjectList)
        {
            foreach (var obj in sqlObjectList.OrderByDescending(c => c.CreateOrder))
            {
                WriteLine($"-- create order {obj.CreateOrder}");
                switch (obj.ObjectType)
                {
                    case SqlObjectTypeEnum.Procedure:
                        WriteLine($"if exists(select 1 from sysobjects where id = object_id('{obj.Schema}.{obj.Name}')and type in ('P', 'PC'))");
                        WriteLine($"    drop procedure {obj.Schema}.{obj.Name}");
                        WriteLine($"go");
                        break;
                    case SqlObjectTypeEnum.Function:
                        // if exists (select 1 from sysobjects where  id = object_id('nav.fnGetPassTypeCode') and type in ('IF', 'FN', 'TF')) drop function nav.fnGetPassTypeCode
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

            WriteLine($"/*-------------------------------------------------------*/");

            foreach (var obj in sqlObjectList.OrderBy(c => c.CreateOrder))
            {
                WriteLine($"-- source file {obj.SqlSourceFile}");
                WriteLine($"-- create order {obj.CreateOrder}");
                Write($"go{Environment.NewLine}{obj.ObjectBody}");
                
                if(!obj.ObjectBody.EndsWith("go"))
                    WriteLine($"go");

                WriteLine($"");
            }

        }
    }
}
