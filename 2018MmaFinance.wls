#!/usr/bin/env wolframscript
(* ::Package:: *)

(* ::Title::Bold:: *)
(*Mathematica\:5728\:91d1\:878d\:9886\:57df\:7684\:4e00\:4e9b\:5e94\:7528*)


(* ::Text::Bold:: *)
(*\:7f16\:7a0b\:73af\:5883\:ff1aMathematica v11.2*)


(* ::Section::Bold:: *)
(*\:4eceMySQL\:8bfb\:53d6\:6570\:636e*)


(* ::Subsection::Bold:: *)
(*\:52a0\:8f7dDatabaseLink*)


(* ::Code::Initialization::Bold:: *)
Needs["DatabaseLink`"]


(* ::Subsection::Bold:: *)
(*\:8fde\:63a5MySQL*)


(* ::Code::Initialization::Bold:: *)
conn=OpenSQLConnection[JDBC["MySQL(Connector/J)","127.0.0.1/tushare"], "Username"->"user","Password"->"123456"];
conn


(* ::Subsection::Bold:: *)
(*\:8bfb\:53d6\:7b2c\:4e00\:4e2a\:8868\:6570\:636e*)


(* ::Code::Initialization::Bold:: *)
tablenames=SQLExecute[conn,"SHOW TABLES;"];
tablenames[[1]]


(* ::Code::Initialization::Bold:: *)
data=SQLExecute[conn, "SELECT * FROM"<>" "<>tablenames[[1]]];
data[[;;5]]//TraditionalForm


(* ::Subsection::Bold:: *)
(*\:6570\:636e\:7684\:6311\:9009\:4e0e\:6574\:7406*)


(* ::Subchapter::Bold:: *)
(*\:65e5\:671f\:7531String\:8f6cDateList*)


(* ::Code::Initialization::Bold:: *)
date=Table[DateList[data[[All,2]][[i]]],{i,Length[data]}];
date[[;;5]]


(* ::Subchapter::Bold:: *)
(*OHLC\:4ef7\:683c*)


(* ::Code::Initialization::Bold:: *)
o=data[[All,3]];
c=data[[All,4]];
h=data[[All,5]];
l=data[[All,6]];


(* ::Subchapter::Bold:: *)
(*\:6210\:4ea4\:91cf*)


(* ::Code::Initialization::Bold:: *)
v=data[[All,7]];


(* ::Section::Bold:: *)
(*\:91d1\:878d\:7ed8\:56fe*)


(* ::Subsection::Bold:: *)
(*\:5e8f\:5217\:56fe*)


(* ::Code::Initialization::Bold:: *)
td=TemporalData[{o,h,l,c},{date}];
td

DateListPlot[td,PlotTheme->"NoAxes",Filling->Bottom,DateTicksFormat->{"MonthShort","/","Day"}]


(* ::Subsection::Bold:: *)
(*\:8721\:70db\:56fe*)


(* ::Code::Initialization::Bold:: *)
ts=Table[{date[[i]],{o[[i]],h[[i]],l[[i]],c[[i]]}},{i,Length[date]}];
ts

CandlestickChart[ts[[;;50]],PlotTheme->"Business"]


(* ::Subsection::Bold:: *)
(*\:4ea4\:6613\:56fe*)


(* ::Code::Initialization::Bold:: *)
tc=Table[{date[[i]],{o[[i]],h[[i]],l[[i]],c[[i]],v[[i]]}},{i,Length[date]}];
tc

InteractiveTradingChart[tc[[;;50]],PlotTheme->"Web"]






