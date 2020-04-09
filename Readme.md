# MsSqlFileMerger
***
Description
--
The library can be use in T4 template and provides an opportunity to merge a few sql files (with stored procs, functions, tables, views) into one sql script for data base scheme update.
***
It could be useful If:
- you store SQL code in *.sql files in Visual Studio project;
- you store one object in one file;
- you use a similar approach to the contents of an SQL file as shown below:
```sql
if exists.... drop...
go
create ....
as
begin
...
end
go
```
- as result you need get the output SQL file in format:
```sql
if exists..ob4.. drop... obj4
if exists..ob3.. drop... obj3
if exists..ob2.. drop... obj2
if exists..ob1.. drop... obj1
go
create ... obj1...
go
create ... obj2...
go
create ... obj3...
go
create ... obj4...
go
```
***
You can define order of generation the following ways:
1) Order of folder array in T4 template
```
    var sqlFolders = new[]{ 
         "Folder01",
         "Folder02",
        };
```
2) Naming files in folder (preffix)
```
01_dbo.ProcSave.sql
02_dbo.ProcUpdate.sql
```

***
It important to note that I use very easy (and picky) algorithm to parse sql file and extract sql objects body based on regex. 
And I tested it only on sql code of my company.
In some other cases it may not work.
You should to check your T4 result sql script.
***

Example of use
--

https://github.com/dimasm61/MsSqlFileMerger/tree/master/MsSqlFileMerger.Example

1. Add reference (MsSqlFileMerger) to Visual Studio project with sql files.
2. Rebuld project. MsSqlFileMerger.dll will be copy to OutDir of solution.
3. Create T4 template, custom tool should be TextTemplatingFileGenerator.
4. Add assambly to T4 script
```XML
<#@ assembly name="$(SolutionDir)[your project folder]\$(OutDir)MsSqlFileMerger.dll"#>
```
5. Import namespace
```
<#@ import namespace="MsSqlFileMerger" #>
```
6. Add code from example to T4 script.

After rebuild your project, MsSqlFileMerger.dll will place in the output directory.
After that T4 engine can find this assembly and use it.

Also you can download assembly (without nuget) in any directory and set direct link.
But mutch easier use merger as nuget package.