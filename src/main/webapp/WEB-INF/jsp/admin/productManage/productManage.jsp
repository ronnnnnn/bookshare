<%@ page language="java" pageEncoding="UTF-8"%>
<body>
	<script type="text/javascript">
		$(function() {

			var parentCat = $('#admin_product_manage_parentCat').combobox({
				valueField : 'id',
				textField : 'name',
				editable : false,
				url : '${pageContext.request.contextPath}/admin/getParentCatJson',
				onSelect : function(params) {
					$.get('${pageContext.request.contextPath}/admin/getSubCatJson', {
						parentId : params.id
					}, function(data) {
						subCat.combobox("clear").combobox('loadData', data);
					}, 'json');
				}
			});
            var myCatId;
			var subCat = $('#admin_product_manage_subCat').combobox({
				valueField : 'id',
				textField : 'name',
				editable : false,
				onSelect : function(params) {
					myCatId = params.id;
					$('#admin_product_datagrid').datagrid({
						url : '${pageContext.request.contextPath}/admin/getProductByCatId',
						fit : true,
						pagination : true,
						idField : 'id',
						checkOnSelect : false,
						selectOnCheck : false,
						fitColumns : true,
						nowrap : false,
						rownumbers : true,
						queryParams: {
							catId:params.id
						},
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
								proAddFun();
							}
						}, '-', {
							text : '删除',
							iconCls : 'icon-remove',
							handler : function() {
								proRemove();
							}
						}, '-', {
							text : '修改',
							iconCls : 'icon-edit',
							handler : function() {
								proEditFun();
							}
						},'-', {
							text : '上架',
							iconCls : 'icon-edit',
							handler : function() {
								proOnSale();
							}
						}, '-', {
							text : '下架',
							iconCls : 'icon-edit',
							handler : function() {
								proOutSale();
							}
						} ]
					});
				}

			});


		});



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
							//$('#admin_proManage_importDialog').dialog('close');
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
		
		function proOnSale(){
			var rows = $('#admin_product_datagrid').datagrid('getChecked');
			var ids = [];
			if (rows.length > 0) {
				$.messager.confirm('确认', '您是否要修改当前选中的选项的授权状态？', function(r) {
					if (r) {
						for ( var i = 0; i < rows.length; i++) {
							ids.push(rows[i].id);
						}
						$.ajax({
							url : '${pageContext.request.contextPath}/admin/proOnSale',
							data : {
								ids : ids.join(',')
							},
							dataType : 'json',
							success : function(d) {
								var v = $('#admin_product_datagrid');
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
					msg : '请勾选要授权的选项！'
				});
			}
		}
		
		function proOutSale(){
			var rows = $('#admin_product_datagrid').datagrid('getChecked');
			var ids = [];
			if (rows.length > 0) {
				$.messager.confirm('确认', '您是否要修改当前选中的选项的授权状态？', function(r) {
					if (r) {
						for ( var i = 0; i < rows.length; i++) {
							ids.push(rows[i].id);

						}
						$.ajax({
							url : '${pageContext.request.contextPath}/admin/proOutSale',
							data : {
								ids : ids.join(',')
							},
							dataType : 'json',
							success : function(d) {
								var v = $('#admin_product_datagrid');
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
					msg : '请勾选要授权的选项！'
				});
			}
		}

		function proManager() {
			var rows = $('#admin_product_datagrid').datagrid('getChecked');
			if (rows.length == 1) {
				setCookie('proid',rows[0].sectionId);
				var url = '${pageContext.request.contextPath}/admin/xjgl/xjgl.jsp';
				addTabs({
					title : '图书详细信息管理',
					href : url,
					closable : true
				});

			} else {
				$.messager.alert('提示', '请勾选一个要管理的章节！');
			}

		}

		
		function proAddFun() {
//			var a = $('#admin_product_manage_subCat').combobox('getText');
//			alert(a);

			var d = $('#mydialog').dialog({
				width : 700,
				height : 500,
				href : '${pageContext.request.contextPath}/admin/productManage/proManageAdd.jsp',
				modal : true,
				cache : false,
				align : 'center',
				title : '添加商品',
				buttons : [ {
					text : '添加',
					handler : function() {
						var rows = $('#admin_product_add_datagrid').datagrid('getChecked');
						var ids = [];

						if (rows.length > 0) {
							$.messager.confirm('确认', '您是否要将当前选中的选项加入此类别？', function(r) {
								if (r) {
									for ( var i = 0; i < rows.length; i++) {
										ids.push(rows[i].id);

									}

									var mycatId = $('#admin_product_manage_subCat').combobox('getValue');


									$.ajax({
										url : '${pageContext.request.contextPath}/admin/proAdd',
										data : {
											ids : ids.join(','),
											catId : parseInt(mycatId)
										},
										dataType : 'json',
										success : function(d) {

											$('#admin_product_datagrid').datagrid('load');
											$.messager.show({
												title : '提示',
												msg : d.msg
											});

											$('#mydialog').dialog('close');
										}
									});

								}
							});

						} else {
							$.messager.show({
								title : '提示',
								msg : '请勾选要授权的选项！'
							});
						}

					}
				} ],
				onClose : function() {
					d.dailog('destroy');
				},
				onLoad : function() {
					    var mcatId = $('#admin_product_manage_subCat').combobox('getValue');
						$('#admin_product_add_datagrid').datagrid({
							url : '${pageContext.request.contextPath}/admin/getOtherBook',
							fit : true,
							pagination : true,
							idField : 'id',
							checkOnSelect : false,
							selectOnCheck : false,
							fitColumns : true,
							nowrap : false,
							rownumbers : true,
							queryParams: {
								catId : mcatId
							},
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
							} ] ]
						});

				}
			});
		}

		function proEditFun() {
			var rows = $('#admin_product_datagrid').datagrid('getChecked');
			if (rows.length == 1) {
				var d = $('<div/>').dialog({
					width : 300,
					height : 370,
					href : '${pageContext.request.contextPath}/admin/productManage/proManageEdit.jsp',
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
										var v = $('#admin_product_datagrid');
										v.datagrid('load');
										v.datagrid('unselectAll');
										v.datagrid('clearChecked');
										/*$('#admin_product_datagrid').datagrid('updateRow', {
											index : $('#admin_product_datagrid').datagrid('getRowIndex', rows[0]),
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

		function proRemove() {
			var rows = $('#admin_product_datagrid').datagrid('getChecked');
			//	var rows=$('#admin_product_datagrid').datagrid('getSelected');
			//	var rows=$('#admin_product_datagrid').datagrid('getSelecteds');
			var ids = [];
			if (rows.length > 0) {
				$.messager.confirm('确认', '您是否要删除当前选中的选项？', function(r) {
					if (r) {
						for ( var i = 0; i < rows.length; i++) {
							ids.push(rows[i].id);
						}
						$.ajax({
							url : '${pageContext.request.contextPath}/admin/proRemove',
							data : {
								ids : ids.join(',')
							},
							dataType : 'json',
							success : function(d) {
								var v = $('#admin_product_datagrid');
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

		function proAppend() {

			$('#admin_product_addForm input').val('');
			$('#admin_product_addDialog').dialog('open');
		}

		function proSearchFun() {
				
			$('#admin_product_datagrid').datagrid({
				url : '${pageContext.request.contextPath}/chapter/vaguedatagrid.action',
				fit : true,
				pagination : true,
				idField : 'sectionId',
				checkOnSelect : false,
				selectOnCheck : false,
				fitColumns : true,
				rownumbers : true,
				queryParams: {
					sectionName: $("input[name$='sectionName']").val()
				},
				frozenColumns : [ [ {
					field : 'sectionId',
					title : '编号',
					width : 150,
					align : 'center',
					//hidden : true,
					checkbox : true
				}, {
					field : 'sectionName',
					title : '章节名称',
					width : 150,
					align : 'center',
				},  {
					field : 'sectionCode',
					title : '章节编号',
					width : 150,
					align : 'center',
				}, {
					field : 'sectionUploader',
					title : '作者',
					width : 150,
					align : 'center',
				},{
					field : 'sectionChecked',
					title : '状态',
					width : 150,
					align : 'center',
					formatter : function(value, row, index) {
						if (value == true) {
							return '已审核';
						} else {
							return '未审核';
						}
					},
				} ] ],
				toolbar : [ {
					text : '删除',
					iconCls : 'icon-remove',
					handler : function() {
						proRemove();
					}
				}, '-', {
					text : '修改',
					iconCls : 'icon-edit',
					handler : function() {
						proEditFun();
					}
				}, '-', {
					text : '对该章节的小节管理',
					iconCls : 'icon-edit',
					handler : function() {
						proManager();
					}
				} ]
			});

			
			//$('#admin_product_datagrid').datagrid('load', serializeObject($('#admin_product_searchForm')));
		}

		function proClearFun() {
			$('#admin_product_layout input[name=name]').val('');
			$('#admin_product_datagrid').datagrid('load', {});
		}
	</script>

	<div id="admin_product_layout" class="easyui-layout" data-options="fit:true,border:false">
		<div data-options="region:'north',title:'查询条件',border:false" style="height: 110px;">
			<form id="admin_product_searchForm">
				检索书籍(可模糊查询):<input name="sectionName" /> </a> <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="proSearchFun()">查询</a> <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-back'" onclick="proClearFun()">清空</a>
			</form>
			<hr style="height:1px;border:none;border-top:10px solid #E5EFFF;" />
			<form id="admin_product_manage_getClassForm" method="post">
				一级类别：<input id="admin_product_manage_parentCat" name="gradeId" style="width: 10%">
				二级类别：<input id="admin_product_manage_subCat" name="departId"> <br>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table id="admin_product_datagrid" data-options="border:false"></table>
		</div>
		
		<div id="admin_proManage_rollingDialog" class="easyui-dialog" data-options="closed:true,modal:true,title:'提示'" style="width: 300px; height: 70px;" align="center">
		    <img alt="上传中。。。" src="${pageContext.request.contextPath}/jslib/imgs/rolling.gif"><br> <a>上传中,请等候...</a>
	    </div>

	</div>




	<div id="mydialog"></div>
<!--
	<div id="produce_add_dialog" class="easyui-dialog" data-options="closed:true">
		<div style="width: 100%; height: 10px"></div>
		<table class="easyui-datagrid" id="product_add_datagrid" >
		</table>
	</div>-->
</body>
</html>
