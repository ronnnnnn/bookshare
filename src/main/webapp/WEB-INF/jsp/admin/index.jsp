<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Index</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-easyui-1.4.4/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-easyui-1.4.4/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/jquery-easyui-1.4.4/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/syUtils.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jslib/ajaxfileupload.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/jslib/jquery-easyui-1.4.4/themes/default/easyui.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/jslib/jquery-easyui-1.4.4/themes/icon.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/ueditor/ueditor.config.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/ueditor/ueditor.all.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/ueditor/themes/default/css/ueditor.css">

    <style type="text/css">
        .button {
            display: inline-block;
            zoom: 1; /* zoom and *display = ie7 hack for display:inline-block */
            *display: inline;
            vertical-align: baseline;
            margin: 0 0px;
            outline: none;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            font: 14px/100% Arial, Helvetica, sans-serif;
            padding: .5em 2em .55em;
            text-shadow: 0 1px 1px rgba(0,0,0,.3);
            -webkit-border-radius: .5em;
            -moz-border-radius: .5em;
            border-radius: .5em;
            -webkit-box-shadow: 0 1px 2px rgba(0,0,0,.2);
            -moz-box-shadow: 0 1px 2px rgba(0,0,0,.2);
            box-shadow: 0 1px 2px rgba(0,0,0,.2);
            margin-top: 0px;
            margin-bottom: 0px;
        }

        .blue {
            color: #E0ECFF;
            border: solid 1px #0076a3;
            background: #0095cd;
            background: -webkit-gradient(linear, left top, left bottom, from(#00adee), to(#0078a5));
            background: -moz-linear-gradient(top,  #00adee,  #0078a5);
            filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#00adee', endColorstr='#0078a5');
        }

        .hr4{ height:1px;border:none;border-top:1px groove skyblue;margin-top: 0px;  margin-bottom: 0px;}
    </style>

	<script type="text/javascript">

        $(function() {
            $('#admin_index_east_calendar').calendar({
                fit : true,
                current : new Date(),
                border : false,
                onSelect : function(date) {
                    $(this).calendar('moveTo', new Date());
                }
            });
        })

		function menuOnclick(name,url) {
			if(url){
				var murl='${pageContext.request.contextPath}'+url;
				addTabs({title:name,href:murl,closable:true});
			}
		}

		function addTabs(optis) {
			var t = $('#lyout_center_tabs');
			if (t.tabs('exists', optis.title)) {
				t.tabs('select', optis.title);
			} else {
				t.tabs('add', optis);
			}
		}
	</script>


</head>

<body class="easyui-layout">
	<div data-options="region:'north'" style="height: 70px;background-color: #E0ECFF">
		<div align="left" style="float: left">
			<h1 style="margin-left: 35px;">后台管理</h1>
		</div>
		<div style="float: right">
			<h4><shiro:principal/></h4>
			<h4 align="center" style="margin-right: 35px"><a href="${pageContext.request.contextPath}/logout">退出</a></h4>
		</div>

	</div>
	<div data-options="region:'south'" style="height: 30px;">
		<div align="center">
			<p>&copy;bookshare</p>
		</div>
	</div>
	<div data-options="region:'east',title:'日历'" style="width: 180px;">
		<%--<jsp:include page="/admin/index/east.jsp"></jsp:include>--%>
        <div id="admin_index_east_calendar"></div>
	</div>
	<div data-options="region:'west',title:'菜单'" style="width: 200px;">
		<%--<jsp:include page="/admin/index/west.jsp"></jsp:include>--%>
			<c:forEach items="${menus}" var="m">
				<button  class="button" style="width:100%;overflow:visible;background: #E0ECFF;border: 1px" target="content" onclick="menuOnclick('${m.name}','${m.url}')">${m.name}</button><br/>
                <hr class="hr4" />
            </c:forEach>
	</div>
	<div data-options="region:'center'" style="background: #eee;">
		<%--<jsp:include page="/admin/index/center.jsp"></jsp:include>--%>
			<div id="lyout_center_tabs" class="easyui-tabs" data-options="fit:true,border:false">
				<div title="首页">欢迎使用！</div>
			</div>
	</div>
</body>
</html>