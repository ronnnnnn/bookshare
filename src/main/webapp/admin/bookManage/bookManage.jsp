<%@ page language="java" pageEncoding="UTF-8"%>
<body>
	<script type="text/javascript">
		$(function() {
			init();
		});
		

		function init(){
				$('#admin_book_datagrid').datagrid({
					url : '${pageContext.request.contextPath}/admin/getAllBook',
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
						width : 150,
						align : 'center',
						//hidden : true,
						checkbox : true
					}, {
						field : 'productName',
						title : '商品名',
						width : 100,
						align : 'center',
					}, {
						field : 'description',
						title : '描述',
						width : 200,
						align : 'center',
					}, {
						field : 'addTime',
						title : '添加时间',
						width : 100,
						align : 'center',
						formatter : function(value, row, index) {
							var tt=new Date(parseInt(value)).toLocaleString().replace(/年|月/g, "-").replace(/日/g, " ");
							return tt;  
						},
					},{
						field : 'fixedPrice',
						title : '原价',
						width : 70,
						align : 'center',
					},{
						field : 'dangPrice',
						title : '特惠',
						width : 70,
						align : 'center',
					},{
						field : 'keywords',
						title : '关键词',
						width : 100,
						align : 'center',
					},{
						field : 'productPic',
						title : '图片',
						width : 100,
						align : 'center',
						formatter : function(value,row,index){
							return '<img style=\"height: 100px;width: 70px;\" src="${pageContext.request.contextPath}/productImages/'+row.productPic+'" />';
					    }
					},{
						field : 'productNum',
						title : '数量',
						width : 100,
						align : 'center',
					},{
						field : 'hasDeleted',
						title : '状态',
						width : 100,
						
						align : 'center',
						formatter : function(value, row, index) {
							if (value == true) {
								return '下架';
							} else {
								return '上架';
							}
						},
					} ] ],
					toolbar : [{
						text : '添加',
						iconCls : 'icon-remove',
						handler : function() {
							bookAddFun();
						}
					}, '-', {
						text : '删除',
						iconCls : 'icon-remove',
						handler : function() {
							bookRemove();
						}
					}, '-', {
						text : '修改',
						iconCls : 'icon-edit',
						handler : function() {
							bookEditFun();
						}
					},'-', {
						text : '管理详细信息',
						iconCls : 'icon-edit',
						handler : function() {
							bookDetailManage();
						}
					}]
				});
		}
		
		
		
		function xsImport() {
			if ($('#uploadfile').val() == '') {
				$.messager.show({
					title : '提示',
					msg : '请选择一个jpg文件',
				});
			} else {
				$('#admin_proManage_rollingDialog').dialog('open');
				$.ajaxFileUpload({
					url : '${pageContext.request.contextPath}/admin/importImage',//用于文件上传的服务器端请求地址
					secureuri : true,//是否启用安全提交，一般设置为false
					fileElementId : 'uploadfile',//文件上传控件的id
					dataType : 'text',//服务器返回的数据类型
					success : function(data) {
						$('#admin_proManage_rollingDialog').dialog('close');
						var obj = jQuery.parseJSON(data);
						if (obj.success) {
							//$('#admin_bookManage_importDialog').dialog('close');
							$('#productPic').val(obj.obj);
							//alert(obj.obj);
						}
						$.messager.show({
							title : '提示',
							msg : obj.msg,
						});
					},
					error : function(data, status, e) {
						$.messager.show({
							title : '提示',
							msg : '服务中断或连接超时导致通信失败！' ,
						});
					}
				});
			}
		}
		
		
		function bookDetailManage() {
			var rows = $('#admin_book_datagrid').datagrid('getChecked');
			if (rows.length == 1) {
				setCookie('Bookid',rows[0].id);
				var url = '${pageContext.request.contextPath}/admin/bookManage/bookDetailManage.jsp';
				addTabs({
					title : '图书详细信息管理',
					href : url,
					closable : true
				});

			} else {
				$.messager.alert('提示', '请勾选一个要管理的章节！');
			}
			
		}

		function bookEditFun() {
			var rows = $('#admin_book_datagrid').datagrid('getChecked');
			if (rows.length == 1) {
				var d = $('<div/>').dialog({
					width : 300,
					height : 370,
					href : '${pageContext.request.contextPath}/admin/bookManage/bookManageEdit.jsp',
					modal : true,
					align : 'center',
					title : '修改商品',
					buttons : [ {
						text : '修改',
						handler : function() {
							$('#admin_productEdit_editForm').form('submit', {
								url : '${pageContext.request.contextPath}/admin/proEdit',
								success : function(data) {
									var obj = jQuery.parseJSON(data);
									if (obj.success) {
										d.dialog('destroy');
										$('#admin_book_datagrid').datagrid('load');
										/*$('#admin_book_datagrid').datagrid('updateRow', {
											index : $('#admin_book_datagrid').datagrid('getRowIndex', rows[0]),
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
						$('#admin_productEdit_editForm').form('load', rows[0]);
						
					}
				});
			} else {
				$.messager.alert('提示', '请勾选一个要编辑的选项！');
			}
		}

		function bookAddFun() {

			var d = $('<div/>').dialog({
				width : 300,
				height : 370,
				href : '${pageContext.request.contextPath}/admin/bookManage/bookManageAdd.jsp',
				modal : true,
				align : 'center',
				title : '添加图书',
				buttons : [ {
					text : '添加',
					handler : function() {
						$('#admin_bookAdd_addForm').form('submit', {
							url : '${pageContext.request.contextPath}/admin/addBook',
							success : function(data) {
								var obj = jQuery.parseJSON(data);
								if (obj.success) {
									d.dialog('destroy');
									$('#admin_book_datagrid').datagrid('load');
									/*$('#admin_book_datagrid').datagrid('updateRow', {
									 index : $('#admin_book_datagrid').datagrid('getRowIndex', rows[0]),
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
					$('#admin_book_datagrid').form('load', '');

				}
			});

		}

		function bookRemove() {
			var rows = $('#admin_book_datagrid').datagrid('getChecked');
			//	var rows=$('#admin_book_datagrid').datagrid('getSelected');
			//	var rows=$('#admin_book_datagrid').datagrid('getSelecteds');
			var ids = [];
			if (rows.length > 0) {
				$.messager.confirm('确认', '您是否要删除当前选中的选项？', function(r) {
					if (r) {
						for ( var i = 0; i < rows.length; i++) {
							ids.push(rows[i].id);
						}
						$.ajax({
							url : '${pageContext.request.contextPath}/admin/removeBook',
							data : {
								ids : ids.join(',')
							},
							dataType : 'json',
							success : function(d) {
								var v = $('#admin_book_datagrid');
								v.datagrid('reload');
								v.datagrid('unselectAll');
								v.datagrid('clearChecked');
								$.messager.show({
									title : '提示',
									msg : d.msg
								});
							}
						});

					}
				});

			} else {
				$.messager.show({
					title : '提示',
					msg : '请勾选要删除的选项！'
				});
			}

		}

		

		

		function proClearFun() {
			$('#admin_book_datagrid input[name=name]').val('');
			$('#admin_book_datagrid').datagrid('load', {});
		}
	</script>

	<div id="admin_book_layout" class="easyui-layout" data-options="fit:true,border:false">
		<div data-options="region:'north',title:'查询条件',border:false" style="height: 70px;">
			<form id="admin_product_searchForm">
				检索书籍(可模糊查询):<input name="sectionName" /> </a> <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="proSearchFun()">查询</a> <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-back'" onclick="proClearFun()">清空</a>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table id="admin_book_datagrid" data-options="border:false"></table>
		</div>
		
		<div id="admin_proManage_rollingDialog" class="easyui-dialog" data-options="closed:true,modal:true,title:'提示'" style="width: 300px; height: 70px;" align="center">
		    <img alt="上传中。。。" src="${pageContext.request.contextPath}/jslib/imgs/rolling.gif"><br> <a>上传中,请等候...</a>
	    </div>

	</div>


</body>
</html>
