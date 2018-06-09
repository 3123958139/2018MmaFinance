#!/usr/bin/env wolframscript
(* ::Package:: *)

(* ::Title:: *)
(*Mathematica\:5728\:91d1\:878d\:9886\:57df\:7684\:4e00\:4e9b\:5e94\:7528*)


(* ::Text:: *)
(*\:7f16\:7a0b\:73af\:5883\:ff1aMathematica v11 .2*)


(* ::Section:: *)
(*\:4eceMySQL\:8bfb\:53d6\:6570\:636e*)


(* ::ItemNumbered:: *)
(*\:52a0\:8f7dDatabaseLink*)


Needs["DatabaseLink`"]


(* ::ItemNumbered:: *)
(*\:8fde\:63a5MySQL*)


conn=OpenSQLConnection[JDBC["MySQL(Connector/J)","127.0.0.1/tushare"], "Username"->"user","Password"->"123456"];
conn


(* ::ItemNumbered:: *)
(*\:8bfb\:53d6\:7b2c\:4e00\:4e2a\:8868\:6570\:636e*)


tablenames=SQLExecute[conn,"SHOW TABLES;"];
tablenames[[1]]


data=SQLExecute[conn, "SELECT * FROM"<>" "<>tablenames[[1]]];(*select the data of the first table*)
data[[;;5]]//TraditionalForm


(* ::ItemNumbered:: *)
(*\:6570\:636e\:7684\:6311\:9009\:4e0e\:6574\:7406*)


(* ::Item:: *)
(*\:65e5\:671f\:7531String\:8f6cDateList*)


date=Table[DateList[data[[All,2]][[i]]],{i,Length[data]}];
date[[;;5]]


(* ::Item:: *)
(*OHLC\:4ef7\:683c*)


o=data[[All,3]];
c=data[[All,4]];
h=data[[All,5]];
l=data[[All,6]];


(* ::Item:: *)
(*\:6210\:4ea4\:91cf*)


v=data[[All,7]];


(* ::Section:: *)
(*\:91d1\:878d\:7ed8\:56fe*)


(* ::ItemNumbered:: *)
(*\:5e8f\:5217\:56fe*)


td=TemporalData[{o,h,l,c},{date}];(*format data for DateListPlot*)
td

DateListPlot[td,PlotTheme->"NoAxes",DateTicksFormat->{"MonthShort","/","Day"}]


(* ::ItemNumbered:: *)
(*\:8721\:70db\:56fe*)


ts=Table[{date[[i]],{o[[i]],h[[i]],l[[i]],c[[i]]}},{i,Length[date]}];(*format data for CandlestickChart*)
ts

CandlestickChart[ts[[;;50]],PlotTheme->"Business"]


(* ::ItemNumbered:: *)
(*\:4ea4\:6613\:56fe*)


tc=Table[{date[[i]],{o[[i]],h[[i]],l[[i]],c[[i]],v[[i]]}},{i,Length[date]}];(*format data for TradingChart*)
tc

TradingChart[tc[[;;50]],PlotTheme->"Web"]






