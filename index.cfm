<html>
<head>
<title>Sortable Hacker News</title>
<script type="text/javascript" src="jquery-latest.js"></script>
<script type="text/javascript" src="jquery.tablesorter.js"></script>
<script type="text/javascript">
$(function() {		
	$("#tablesorter-demo").tablesorter({sortList:[[0,0],[2,1]], widgets: ['zebra']});
});	
</script>
<link rel="stylesheet" href="jq.css" type="text/css" media="print, projection, screen" />
<link rel="stylesheet" href="style.css" type="text/css" media="print, projection, screen" />
</head>
  
<body>
<cfhttp url="http://open.dapper.net/RunDapp?dappName=HNhomepage&v=1&applyToUrl=http%3A%2F%2Fnews.ycombinator.com%2F" method="get">

<cfscript>
    xmlfile	= xmlparse(cfhttp.filecontent); 
    xmlsize	= (arraylen(xmlfile.elements.xmlchildren)-1); 
</cfscript>
<table id="tablesorter-demo" class="tablesorter" width="100%"> 
<thead> 
<tr> 
    <th>#</th> 
    <th>Points</th> 
    <th>Comments</th> 
    <th>Title</th> 
    <th>Domain</th> 
    <th>Submitter</th> 
    <th>Hrs ago</th> 
</tr> 
</thead> 
<tbody>
<cfloop index="i" from="1" to="#xmlsize#">
<cftry>
<cfparam name="xmlfile.elements.Post[i].Domain.xmlText" default="">
	<cfoutput>
	<tr>
		<td>#i#</td>
		<td>#Replace(xmlfile.elements.Post[i].PointsNum.xmlText, "points","")#</td>
		<td class="sortable-numeric"><a target="_blank" href="#xmlfile.elements.Post[i].NumComments.xmlAttributes.href#">#Trim(Replace(Replace(Replace(xmlfile.elements.Post[i].NumComments.xmlText,"comments",""),"comment",""),"discuss","0"))#</a></td>
		<td><a target="_blank" href="#xmlfile.elements.Post[i].Title.xmlAttributes.href#">#xmlfile.elements.Post[i].Title.xmlText#</a></td>
		<td>#Replace(Replace(xmlfile.elements.Post[i].Domain.xmlText,"(", ""), ")","")#</td>
		<td><a target="_blank" href="#xmlfile.elements.Post[i].SubmittedBy.xmlAttributes.href#">#xmlfile.elements.Post[i].SubmittedBy.xmlText#</a></td>
		<td><cfset when ="#Replace(Replace(Replace(Replace(xmlfile.elements.Post[i].WhenPosted.xmlText,"|",""),"hours",""),"hour",""),"ago","")#">
		<cfif FindNoCase("minutes","#when#")> <cfset when = Replace(when,"minutes","")/60><cfset when = Left(when,3)><cfset when = Left(when,3)><cfelseif FindNoCase("day","#when#")><cfset when = 24><cfset when = Left(when,3)></cfif>#when#</td>
	</tr>
	</cfoutput>
	<cfcatch></cfcatch>
</cftry>
</cfloop>
</tbody>
</table>
<center><font size="-1">HNSort is maintained by <a href="http://www.scrollinondubs.com">Sean Tierney</a> and is not affiliated with <a href="http://news.ycombinator.com">Hacker News</a>. Here's a <a href="http://dionidium.com/projects/greasemonkey/hnsort.user.js">Greasemonkey script</a> that does the same thing. Hosting by <a href="http://www.jumpbox.com">JumpBox</a>.<br/>
<a href="http://www.jumpbox.com"><img src="http://www.shareasale.com/image/tools728x90.gif" align="center" border ="0"></a>
</font></center>

<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-189190-12");
pageTracker._trackPageview();
} catch(err) {}</script>
</body>
</html>