// Copyright 2015 Intergral GmbH// Licensed under the Apache License, Version 2.0 (the "License");// you may not use this file except in compliance with the License.// You may obtain a copy of the License at// http://www.apache.org/licenses/LICENSE-2.0// Unless required by applicable law or agreed to in writing, software// distributed under the License is distributed on an "AS IS" BASIS,// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.// See the License for the specific language governing permissions and// limitations under the License.<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml"><cfobject type="Java" class="java.lang.System" name="sys"/><cfset start = sys.currentTimeMillis()/><cfset jVer = sys.getProperty("java.specification.version")/><cfset contextPath = getDirectoryFromPath(getCurrentTemplatePath())/><cfset contextPath = contextPath.subString(0, contextPath.lastIndexOf("layout") -1)><cfif contextPath CONTAINS "webapps">    <cfset contextPath = contextPath.subString(contextPath.lastIndexOf("webapps") + 7, contextPath.length())>    <cfelseif contextPath CONTAINS "wwwroot" >    <cfset contextPath = contextPath.subString(contextPath.lastIndexOf("wwwroot") + 7, contextPath.length())></cfif><head>    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>    <title>FusionReactor ColdBox Test Application</title>    <link rel="icon" type="image/png" href="<cfoutput>#contextPath#</cfoutput>/resources/img/favicon.png" />    <link href="<cfoutput>#contextPath#</cfoutput>/resources/css/bootstrap.min.css" rel="stylesheet"/>    <link href="<cfoutput>#contextPath#</cfoutput>/resources/css/bootstrap-theme.min.css" rel="stylesheet"/>    <link href="<cfoutput>#contextPath#</cfoutput>/resources/css/custom.css" rel="stylesheet"/>    <link href="<cfoutput>#contextPath#</cfoutput>/resources/css/font-awesome.min.css" rel="stylesheet"/>    <script src="<cfoutput>#contextPath#</cfoutput>/resources/js/jquery-1.11.3.min.js"></script>    <script src="<cfoutput>#contextPath#</cfoutput>/resources/js/bootstrap.min.js"></script></head><body><nav class="navbar navbar-default" role="navigation" style="background-color: #000000; background-image: none;">    <div class="container-fluid">        <div class="navbar-header">            <a class="navbar-brand" href="http://www.intergral.com" target="_blank">                <img height='24px' src="<cfoutput>#contextPath#</cfoutput>/resources/img/logo-invert.svg" alt="Spring Test Suite">            </a>            <a class="navbar-brand" href="/CFIDE/administrator/">                <img height='24px' src="<cfoutput>#contextPath#</cfoutput>/resources/img/cflogo.png" alt="CFIDE Administrator">            </a>        </div>        <p class="navbar-text"><a style="color: #FFFFFF" href="<cfoutput>#contextPath#</cfoutput>">FusionReactor ColdBox Demo App</a></p>        <a style="padding-left: 30px" target="_blank" class="navbar-brand navbar-right" href="/fusionreactor.jsp.cfml/findex.html"><img                height='24px' src="<cfoutput>#contextPath#</cfoutput>/resources/img/fusionreactor_logo2.png" alt="FusionReactor"></a>        <ul class="nav navbar-nav navbar-right">            <li class="dropdown">                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"                   aria-expanded="false">Extras<span class="caret"></span></a>                <ul class="dropdown-menu">                    <li><a href="?event=static.exceptionExample">Exception</a></li>                    <li><a href="?event=static.longjdbc">Long JDBC</a></li>                    <li><a href="?event=static.longrequest">Long Request</a></li>                </ul>            </li>                <cfif StructKeyExists(SESSION, "current_user") >                    <cflogin>                        <cfloginuser name="#prc.user.username#" password="#prc.user.password#" roles="user" />                    </cflogin>                <cfelse>                    <cflogout>                </cfif>            <cfif isUserLoggedIn()>                <li><a href="?event=shop.list">Shop</a></li>                <li><a href="?event=user.home">Profile</a></li>                <li><a href="?event=session.destroy">Logout</a></li>            <cfelse>                <li><a href="?event=user.new">Signup</a></li>                <li><a href="?event=session.new">Login</a></li>            </cfif>        </ul>    </div></nav><div class="row">    <div class="col-lg-8 col-lg-offset-2">        <cfoutput>#getInstance("messagebox@cbmessagebox").renderIt( class="alert")#</cfoutput>    </div></div><cfoutput><!--- Render the View Here --->#renderView()#</cfoutput><div class="row">    <hr/>    <div class="col-lg-2 col-lg-offset-4">        <p align="center">            <cfset dur = sys.currentTimeMillis() - start />            <span style="font-size:small"><span style="font-weight: bold;">Duration</span>: <cfoutput>#dur#</cfoutput> ms</span>        </p>        <script type="text/javascript">            <cftry>                <cfset frapiObj = createObject("java", "com.intergral.fusionreactor.api.FRAPI")>                <cfset frapi = frapiObj.getInstance()>                <cfset script = frapi.getUemTrackingScript()>                <cfoutput>#script#</cfoutput>                <cfset uem = "added">                <cfcatch>                    <cfset uem = "failed">                </cfcatch>            </cftry>            <cfheader name="uem" value=#script#>        </script>        <cftry>            <cfset frapiObj = createObject("java", "com.intergral.fusionreactor.api.FRAPI")>            <cfset frapi = frapiObj.getInstance()>            <cfset frver = frapi.getFRVersion().getVersion() & ", <span style='font-weight: bold;'>Build</span>: " & frapi.getFRVersion().getBuildNumber() & ", <span style='font-weight: bold;'>Date</span>: " & frapi.getFRVersion().getBuildTime().toString()>            <cfset frapiAvi = "available">            <cfcatch>                <cfset frver = "< FR 6.0.0">                <cfset frapiAvi = "un-available">            </cfcatch>        </cftry>        <p align="center">            <span style="font-size:small"><span style="font-weight: bold;">UEM script</span>: <cfoutput>#uem#</cfoutput></span>        </p>        <p align="center">            <span style="font-size:small"><span style="font-weight: bold;">Java Version</span>: <cfoutput>#jVer#</cfoutput></span>        </p>        <p align="center">            <span style="font-size:small"><span style="font-weight: bold;">FRAPI is</span>: <cfoutput>#frapiAvi#</cfoutput></span>        </p>    </div>    <div class="col-lg-2">        <cftry>            <cfset frapiObj = createObject("java", "com.intergral.fusionreactor.api.FRAPI")>            <cfset frapi = frapiObj.getInstance()>            <cfset freeMem = frapi.getFreeMemory() >            <cfset totalMem = frapi.getTotalMemory() >            <cfset usedMem = frapi.getUsedMemory() >            <cfset allocMem = frapi.getAllocatedMemory() >            <cfset cpu = frapi.getCpuUsage() >            <cfset startTime = frapi.getStartTimeString() >            <cfset upTime = frapi.getUptime() >            <cfset formatter = createObject("java", "com.intergral.fusionreactor.coldbox.Formatter") >            <cfset formattedTime = formatter.formatLongAsUpTimeString( upTime, false, 2) >            <cfcatch>                <cfset freeMem = 0 >                <cfset totalMem = 0 >                <cfset usedMem = 0 >                <cfset allocMem = 0 >                <cfset cpu = 0>                <cfset startTime = "n/a" >                <cfset upTime = 0 >                <cfset formattedTime = 0 >            </cfcatch>        </cftry>        <p align="center">            <span style="font-size: small; "><span style="font-weight: bold;">Memory</span>: </span>            <span style="font-size: small; "><cfoutput>#NumberFormat( usedMem/(1024*1024), "99" )#MB Used / #NumberFormat( allocMem/(1024*1024), "99" )#MB Allocated / #NumberFormat( totalMem/(1024*1024), "99" )#MB Total</cfoutput></span>        </p>        <p align="center">            <span style="font-size: small; "><span style="font-weight: bold;">CPU</span>: </span>            <span style="font-size: small; "><cfoutput>#NumberFormat(cpu, "99.99")#%</cfoutput></span>        </p>        <p align="center">            <span style="font-size: small; "><span style="font-weight: bold;">StartTime</span>: </span>            <span style="font-size: small; "><cfoutput>#startTime#</cfoutput></span>        </p>        <p align="center">            <span style="font-size: small; "><span style="font-weight: bold;">UpTime</span>: </span>            <span style="font-size: small; "><cfoutput>#formattedTime#</cfoutput></span>        </p>    </div></div><div class="row">    <div class="col-lg-4 col-lg-offset-4">        <p align="center">            <span style="font-size:small"><span style="font-weight: bold;">FusionReactor Version</span>: <cfoutput>#frver#</cfoutput></span>        </p>    </div></div><div class="row">    <hr/>    <p align="center">        <span style="font-size: 24px; font-weight: bold;">Powered By:</span>    </p>    <p align="center">        <a href="http://www.coldbox.org" target="_blank">            <img src="<cfoutput>#contextPath#</cfoutput>/resources/img/poweredby.png" border="0">        </a>        <a href="http://www.fusion-reactor.com/" target="_blank">                <img style="height: 50px; width: 200px;" src="<cfoutput>#contextPath#</cfoutput>/resources/img/fusionreactor_logo.png" />        </a>    </p></div></body></html>