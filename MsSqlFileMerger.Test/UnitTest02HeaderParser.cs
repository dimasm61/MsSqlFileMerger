using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using MsSqlFileMerger;

namespace MsSqlFileMerger.Test
{
    [TestClass]
    public class UnitTest02HeaderParser
    {

        private void TestAndCheckResult(ref string[] lines, int startDefinitionLine, string trueObjectType, string trueObjectSchema, string trueObjectName)
        {

            var idx = 0;
            var startObjectLineIdx = 0;
            var objectType = "";
            var objectSchema = "";
            var objectName = "";

            var s = lines.ExtractObjectInfo(ref idx, ref startObjectLineIdx, ref objectType, ref objectSchema, ref objectName);

            s = s.Trim();

            Assert.AreEqual(trueObjectType     , objectType        , "Not match type");
            Assert.AreEqual(trueObjectSchema   , objectSchema      , "Not match schema");
            Assert.AreEqual(trueObjectName     , objectName        , "Not match name");
            Assert.AreEqual(startDefinitionLine, startObjectLineIdx, "Not match start line");
        }

        [TestMethod]
        public void TestMethod_ParseCommentFilter01()
        {
            var lines = new[]
            {
                "/*comment*/ alter",
                "     function [nav].[fnGetDirectionByInPos]",
                "     as",
                "     begin",
            };

            TestAndCheckResult(ref lines, 0, "function", "nav", "fnGetDirectionByInPos");
        }

        [TestMethod]
        public void TestMethod_ParseCommentFilter02()
        {
            var lines = new[]
            {
                "/*",
                " comment",
                " comment*/",
                " go -- comment",
                "alter",
                "     function db1.[nav].[fnGetDirectionByInPos]",
                "     as",
                "     begin",
            };

            TestAndCheckResult(ref lines, 4, "function", "nav", "fnGetDirectionByInPos");
        }

        [TestMethod]
        public void TestMethod_ParseCommentFilter03()
        {
            var lines = new[]
            {
                "/*",
                " comment",
                " comment*/ alter -- comment",
                "     function [db1]..[fnGetDirectionByInPos]",
                "     as",
                "     begin",
            };

            TestAndCheckResult(ref lines, 0, "function", "dbo", "fnGetDirectionByInPos");
        }

        [TestMethod]
        public void TestMethod_ParseCommentFilter04()
        {
            var lines = new[]
            {
                "/*",
                " comment",
                " comment*/ alter /*",
                " comment",
                " comment*/ ",
                "     function [fnGetDirectionByInPos]",
                "     as",
                "     begin",
            };

            TestAndCheckResult(ref lines, 0, "function", "dbo", "fnGetDirectionByInPos");
        }

        [TestMethod]
        public void TestMethod_ParseCommentFilter05()
        {
            var lines = new[]
            {
                "if exists (select 1 from sysobjects where id = object_id('atm.AutoLineCross')and type in ('P','PC'))  drop procedure atm.AutoLineCross",
                "",
                "go",
                "create function [nav].[fnGetDirectionByInPos] /*     */",
                "  return ",
                "as",
                "begin",
            };

            TestAndCheckResult(ref lines, 3, "function", "nav", "fnGetDirectionByInPos");
        }

        [TestMethod]
        public void TestMethod_ParseCommentFilter06()
        {
            var lines = new[]
            {
                "if exists (select 1 from sysobjects where id = object_id('atm.AutoLineCross')and type in ('P','PC'))  drop procedure atm.AutoLineCross",
                "",
                " go",
                "create function [nav].[fnGetDirectionByInPos] /*     */",
                "  return ",
                "as",
                "begin",
            };

            TestAndCheckResult(ref lines, 3, "function", "nav", "fnGetDirectionByInPos");
        }
        [TestMethod]
        public void TestMethod_ParseCommentFilter07()
        {
            var lines = new[]
            {
                "if exists (select 1 from sysobjects where id = object_id('atm.AutoLineCross')and type in ('P','PC'))  drop procedure atm.AutoLineCross",
                "",
                " go",
                "create function [nav].[fnGetDirectionByInPos] /*     */",
                "-- alter function [nav].[fnGetDirectionByInPos] /*     */ return as go",
                "  return ",
                "as",
                "begin",
            };

            TestAndCheckResult(ref lines, 3, "function", "nav", "fnGetDirectionByInPos");
        }

        [TestMethod]
        public void TestMethod_ParseCommentFilter08()
        {
            var lines = new[]
            {
                "if exists (select 1 from sysobjects where id = object_id('atm.AutoLineCross')and type in ('P','PC'))  drop procedure atm.AutoLineCross",
                "",
                " go",
                "create function [nav].[fnGetDirectionByInPos] /*  alter function [nav].[fnGetDirectionByInPos] return as go */",
                "  return ",
                "as",
                "begin",
            };

            TestAndCheckResult(ref lines, 3, "function", "nav", "fnGetDirectionByInPos");
        }

        [TestMethod]
        public void TestMethod_ParseCommentFilter09()
        {
            var lines = new[]
            {
                "go",
                "create function [nav].[fnGetDirectionByInPos] /*  alter function [nav].[fnGetDirectionByInPos] return as go */",
                "  return ",
                "as",
                "begin",
            };

            TestAndCheckResult(ref lines, 1, "function", "nav", "fnGetDirectionByInPos");
        }

        [TestMethod]
        public void TestMethod_ParseCommentFilter10()
        {
            var lines = new[]
            {
                "-----------------------------------------------------------",
                "go",
                "create function Fun10",
                "  return ",
                "as",
                "begin",
            };

            TestAndCheckResult(ref lines, 2, "function", "dbo", "Fun10");
        }

        [TestMethod]
        public void TestMethod_ParseCommentFilter11()
        {
            var lines = new[]
            {
                "-----------------------------------------------------------",
                "go",
                "create function dbo.func04() returns int as begin return 1 end",
            };

            TestAndCheckResult(ref lines, 2, "function", "dbo", "func04");
        }

        [TestMethod]
        public void TestMethod_ParseCommentFilter12()
        {
            var lines = new[]
            {
                "go",
                "alter view db.view01",
                "as",
                "    select 1"
            };

            TestAndCheckResult(ref lines, 1, "view", "db", "view01");
        }

        [TestMethod]
        public void TestMethod_ParseCommentFilter13()
        {
            var lines = new[]
            {
                "go",
                "alter view db.view01",
                "as-- comment",
                "    select 1"
            };

            TestAndCheckResult(ref lines, 1, "view", "db", "view01");
        }

        [TestMethod]
        public void TestMethod_ParseCommentFilter14()
        {
            var lines = new[]
            {
                "go",
                "create procedure nav.PassArchiveSelect",
                "        @skip        int",
                "      , @take        int",
                "      , @dateFrom    datetime         = null",
                "      , @dateTo      datetime         = null",
                "      , @txtFilter   nvarchar(100)    = null",
                "      , @vtsCode         nvarchar(5)  = null",
                "      , @vtsZoneCode     nvarchar(5)  = null",
                "      , @passFairwayCode nvarchar(10) = null",
                "      , @passDirection   nvarchar(10) = null",
                "      , @vesselGuid      uniqueidentifier = null",
                "      , @countAll   int output",
                "as",
                "begin",
                "    --",
            };

            TestAndCheckResult(ref lines, 1, "procedure", "nav", "PassArchiveSelect");
        }
    }
}
