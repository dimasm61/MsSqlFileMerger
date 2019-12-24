using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MsSqlFileMerger
{
    internal class SqlObjectFileLoader
    {
        private SqlObjectParser _parser;

        public SqlObjectFileLoader(SqlObjectParser parser)
        {
            _parser = parser;
        }

        public List<SqlObject> LoadFile(string fileName, Encoding encoding, ref int createOrderCounter, bool isSpToEndFile)
        {
            var txt = File.ReadAllLines(fileName, encoding);
            if (txt.Length > 0 && txt[0].StartsWith("T4_IGNORE"))
                return new List<SqlObject>();

            return _parser.ParseStrArray(ref txt, ref createOrderCounter, fileName, isSpToEndFile);

        }
    }
}
