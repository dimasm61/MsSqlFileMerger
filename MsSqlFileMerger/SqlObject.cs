
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
        public string ObjectType;
        public string ObjectBody;
        public string Schema;
        public string Name;


        private static string[] _sqlReservedWords = new[] { "create", "procedure", "function", "view", "table", "login", "schema", "trigger", "service" };
        public void ParseName(string lineWithName)
        {

            var arr = lineWithName.Split(' ','(', '@');

            foreach (var s in arr)
            {
                var s2 = s;

                if (string.IsNullOrWhiteSpace(s2)) continue;

                if (_sqlReservedWords.Contains(s2.ToLower())) continue;

                if (s2.Contains("--"))
                {
                    var commentPos = s2.IndexOf("--");
                    s2 = s2.Remove(commentPos, s2.Length - commentPos);
                }

                s2 = s2.Trim(' ', '(', '-', '[');

                if (s2.Contains("."))
                {
                    var arr2 = s2.Split('.');
                    Schema = arr2[0]?.Trim();
                    Name = arr2[1]?.Trim();
                }
            }// foerach
        }
    }
}
