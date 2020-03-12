
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MsSqlFileMerger
{
    public class SqlObject
    {
        public string SqlSourceFile;
        public int CreateOrder;
        public SqlObjectTypeEnum ObjectType;
        public string ObjectBody;
        public string Schema;
        public string Name;

        //private static string[] _sqlReservedWords = new[] { "create", "procedure", "function", "view", "table", "login", "schema", "trigger", "service" };
    }
}
