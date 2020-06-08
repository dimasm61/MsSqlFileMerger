using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.VisualStudio.TextTemplating;

namespace MsSqlFileMerger
{
    public interface IMerger
    {

        TextTransformation Output { get; set; }
        string RowDelimiterDropCreate { get; set; }
        string RowDelimiterObject { get; set; }
        bool IsWriteGenOrder { get; set; }
        bool IsWriteFileName { get; set; }
        bool IsTraceIfFindIgnoreKeyword { get; set; }
        void SetScriptRootFolder(string solutionPath, string scriptRootFolder);

        void Load(string dbName
            , string rootPath
            , Encoding encoding
            , string[] sqlSourceFolders
            , bool isSpToEndFile
            , string searchPattern = "*.sql"
            , string[] excludeFileList = null);

        /// <summary>
        /// Depricated need use WriteScriptSummary()
        /// </summary>
        void WriteSqlScript();

        void WriteScriptSummary();

        void ReplaceInBody(string pattern, string newStr);

        void WriteScripts(string rootPath, Encoding encoding, string[] sqlSourceFiles);
    }

    public interface IMergerForTest
    {
        SqlObjectWriter SqlObjectWriter { get; set; }
        List<SqlObject> SqlObjectList { get; set; }
        SqlObjectParser Parser { get; set; }
        ISqlFileLoader SqlFileLoader { get; set; }
    }

    public interface ISqlFileLoader
    {
        bool IsTraceIfFindIgnoreKeyword { get; set; }

        List<SqlObject> LoadFile(
            //TextTransformation output
            string solutionPath
            , string fileName
            , Encoding encoding
            , ref int createOrderCounter
            , bool isSpToEndFile
            , List<LogItem> outputList);

        void Init(SqlObjectParser parser);
    }
}
