<%@ page language="java" pageEncoding="UTF-8"%>
<body>
	<script type="text/javascript">
		$(function() {
			init();
		});
		

		function init(){
				$('#admin_book_detail_datagrid').datagrid({
					url : '${pageContext.request.contextPath}/admin/getBookDetail',
					queryParams: {
						Bookid: getCookie("Bookid")	
					},
					fit : true,
					pagination : true,
					idField : 'id',
					checkOnSelect : false,
					selectOnCheck : false,
					fitColumns : true,
					nowrap : false,
					rownumbers : true,
					frozenColumns : [ [ {
						field : 'id',
						title : '编号',
						width : 50,
						align : 'center',
						//hidden : true,
						checkbox : true
					}, {
						field : 'author',
						title : '作者',
						width : 50,
						align : 'center',
					}, {
						field : 'publishing',
						title : '出版社',
						width : 150,
						align : 'center',
					}, {
						field : 'publishTime',
						title : '出版时间',
						width : 100,
						align : 'center',
					
					},{
						field : 'wordNumber',
						title : '字数',
						width : 70,
						align : 'center',
					},{
						field : 'whichEdtion',
						title : '修订版本',
						width : 70,
						align : 'center',
					},{
						field : 'totalPage',
						title : '总页数',
						width : 50,
						align : 'center',
					},{
						field : 'printTime',
						title : '打印时间',
						width : 100,
						align : 'center',
						
					},{
						field : 'printNumber',
						title : '打印版本',
						width : 100,
						align : 'center',
					},{
						field : 'isbn',
						title : 'isbn号',
						width : 100,
						align : 'center',
					},{
						field : 'authorSummary',
						title : '作者简介',
						width : 150,
						align : 'center',
					},{
						field : 'catalogue',
						title : '目录',
						width : 150,
						align : 'center',
					}] ],
					toolbar : [{
						text : '修改',
						iconCls : 'icon-edit',
						handler : function() {
							bookDetailEditFun();
						}
					}]
				});
				
		}
		
		


		function bookDetailEditFun() {
			
			var rows = $('#admin_book_detail_datagrid').datagrid('getChecked');
			if (rows.length == 1) {
				var d = $('<div/>').dialog({
					width : 300,
					height : 370,
					href : '${pageContext.request.contextPath}/admin/bookManage/bookDetailEdit.jsp',
					modal : true,
					align : 'center',
					title : '修改详细信息',
					buttons : [ {
						text : '修改',
						handler : function() {
							$('#admin_bookDetailEdit_editForm').form('submit', {
								url : '${pageContext.request.contextPath}/admin/bookDetailEdit',
								success : function(data) {
									var obj = jQuery.parseJSON(data);
									if (obj.success) {
										d.dialog('destroy');
										$('#admin_book_detail_datagrid').datagrid('load');
										/*$('#admin_book_detail_datagrid').datagrid('updateRow', {
											index : $('#admin_book_detail_datagrid').datagrid('getRowIndex', rows[0]),
											row : obj.obj
										});*/
									}

									$.messager.show({
										title : '提示',
										msg : obj.msg,
									});
								}
							});
						}
					} ],
					onClose : function() {
						$(this).dailog('destroy');
					},
					onLoad : function() {
						$('#admin_bookDetailEdit_editForm').form('load', rows[0]);
						
					}
				});
			} else {
				$.messager.alert('提示', '请勾选一个要编辑的选项！');
			}
		}
		
		

		function proClearFun() {
			$('#admin_book_detail_datagrid input[name=name]').val('');
			$('#admin_book_detail_datagrid').datagrid('load', {});
		}
	</script>

	<div id="admin_book_detail_layout" class="easyui-layout" data-options="fit:true,border:false">
		
		<div data-options="region:'center',border:false">
			<table id="admin_book_detail_datagrid" data-options="border:false"></table>
		</div>
		
		<div id="admin_proManage_rollingDialog" class="easyui-dialog" data-options="closed:true,modal:true,title:'提示'" style="width: 300px; height: 70px;" align="center">
		    <img alt="上传中。。。" src="${pageContext.request.contextPath}/jslib/imgs/rolling.gif"><br> <a>上传中,请等候...</a>
	    </div>

	</div>


</body>
</html>
