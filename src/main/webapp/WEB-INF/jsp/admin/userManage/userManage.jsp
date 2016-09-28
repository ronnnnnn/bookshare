<%@ page language="java" pageEncoding="UTF-8"%>
<body>
	<script type="text/javascript">
		$(function() {
			init();
		});
		

		function init(){
				$('#admin_user_datagrid').datagrid({
					url : '${pageContext.request.contextPath}/admin/user/all',
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
						field : 'username',
						title : '用户名',
						width : 100,
						align : 'center',
					}, {
						field : 'organization',
						title : '所属组织',
						width : 200,
						align : 'center',
						formatter : function(value, row, index) {
							var orgname = "";
							if (value != null && value != undefined && value != '') {

								$.ajax({
									type: 'get',
									url: '${pageContext.request.contextPath}/admin/org/many/' + value,
									dataType: 'json',
									async:false,
									success: function (data) {
										$.each(data, function (index, value) {
											  orgname += value.name + ",";
										});
									},
									error: function (data) {
                                          alert("err");
									}
								});
							}else{
								return orgname;
							}
							return orgname;
						},
					}, {
						field : 'roleIds',
						title : '角色列表',
						width : 200,
						align : 'center',
						formatter : function(value, row, index) {
							var rolename = "";
							if (value != null && value != undefined && value != '') {

								$.ajax({
									type: 'get',
									url: '${pageContext.request.contextPath}/admin/role/many/' + value,
									dataType: 'json',
									async:false,
									success: function (data) {
										$.each(data, function (index, value) {
											rolename += value.description + ",";
										});
									},
									error: function (data) {
										alert("err");
									}
								});
							}else{
								return rolename;
							}
							return rolename;
						},
					},{
						field : 'email',
						title : '邮箱',
						width : 150,
						align : 'center',
					},{
						field : 'nickname',
						title : '名字',
						width : 100,
						align : 'center',
					},{
						field : 'account',
						title : '账户金额',
						width : 100,
						align : 'center',

					},{
						field : 'locked',
						title : '状态',
						width : 100,
						align : 'center',
						formatter : function(value, row, index) {
							if (value == true) {
								return '锁定';
							} else {
								return '活动';
							}
						},
					} ] ],
					toolbar : [{
						text : '添加',
						iconCls : 'icon-remove',
						handler : function() {
							userAddFun();
						}
					}, '-', {
						text : '删除',
						iconCls : 'icon-remove',
						handler : function() {
							userRemove();
						}
					}, '-', {
						text : '修改',
						iconCls : 'icon-edit',
						handler : function() {
							userEditFun();
						}
					},'-', {
						text : '修改密码',
						iconCls : 'icon-edit',
						handler : function() {
							passwordEdit();
						}
					}]
				});
		}
		

		
		function passwordEdit() {

		}

		function userEditFun() {
			var rows = $('#admin_user_datagrid').datagrid('getChecked');
			if (rows.length == 1) {
				var d = $('#mydialog-e').dialog({
					width : 270,
					height : 285,
					href : '${pageContext.request.contextPath}/admin/user/editpanel',
					modal : true,
					align : 'center',
					title : '修改用户',
					buttons : [ {
						text : '修改',
						handler : function() {
							$('#admin_user_editForm').form('submit', {
								url : '${pageContext.request.contextPath}/admin/proEdit',
								success : function(data) {
									var obj = jQuery.parseJSON(data);
									if (obj.success) {
										d.dialog('destroy');
										$('#admin_user_datagrid').datagrid('load');
										/*$('#admin_user_datagrid').datagrid('updateRow', {
											index : $('#admin_user_datagrid').datagrid('getRowIndex', rows[0]),
											row : obj.obj
										});*/
									}

									$.messager.show({
										title : '提示',
										msg : obj.msg,
									});

									$('#mydialog').dialog('close');
								}
							});
						}
					} ],
					onClose : function() {
						$(this).dailog('destroy');
					},
					onLoad : function() {
						$('#admin_user_editForm').form('load', rows[0]);
					}
				});
			} else {
				$.messager.alert('提示', '请勾选一个要编辑的选项！');
			}
		}

		function userAddFun() {

			$.ajax({
				type: 'get',
				contentType: 'application/json',
				url: '${pageContext.request.contextPath}/admin/role/all/list',
				processData: false,
				dataType: 'json',
				async:false,
				success: function(data) {
					$("#role-select").empty();
					$.each(data, function (index, value) {
						$("#role-select").append("<option value='"+value.id+"'>"+value.description+"</option>");
					});
				},
				error: function() {
					alert('Err...');
				}
			});

			$.ajax({
				type: 'get',
				contentType: 'application/json',
				url: '${pageContext.request.contextPath}/admin/org/all/list',
				processData: false,
				dataType: 'json',
				async:false,
				success: function(data) {
					$("#org-select").empty();
					$.each(data, function (index, value) {
						$("#org-select").append("<option value='"+value.id+"'>"+value.name+"</option>");
					});
				},
				error: function() {
					alert('Err...');
				}
			});

			$('#admin_user_addForm input').val('');
			$('#admin_user_addForm select').val('');
			$('#admin_user_addDialog').dialog('open');

			$('#org-select').combobox({
				onChange: function() {
					var value = $('#org-select').combobox('getValues');
					console.log(value);
					console.log(value.join(','));
					$('#org-select').val(value);
				}
			});

			$('#role-select').combobox({
				onChange: function() {
					var value = $('#role-select').combobox('getValues');
					console.log(value);
					console.log(value.join(','));

				}
			});

		}

		function userRemove() {
			var rows = $('#admin_user_datagrid').datagrid('getChecked');
			//	var rows=$('#admin_user_datagrid').datagrid('getSelected');
			//	var rows=$('#admin_user_datagrid').datagrid('getSelecteds');
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
								var v = $('#admin_user_datagrid');
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
			$('#admin_user_datagrid input[name=name]').val('');
			$('#admin_user_datagrid').datagrid('load', {});
		}

		function registerUser() {
			var username = $("input[name='username']").val();
			var password = $("input[name='password']").val();
			var roleIds = $('#role-select').combobox('getValues');
			var locked = $("input[name='locked']").val();
			var email = $("input[name='email']").val();
			var nickname = $("input[name='nickname']").val();
			var account = $("input[name='account']").val();
			var organization =  $('#org-select').combobox('getValues');
			$.ajax({
				type: 'POST',
				contentType: 'application/json',
				url: '${pageContext.request.contextPath}/admin/user/register',
				processData: false,
				dataType: 'json',
				data : '{"username":\"'+username+'\","password":\"'+password+'\","roleIds":\"'+roleIds+'\","locked":\"'+locked+'\","email":\"'+email+'\","nickname":\"'+nickname+'\","account":\"'+account+'\","organization":\"'+organization+'\"}',
				success: function(data) {
					if(data){
						$('#admin_user_datagrid').datagrid('load');
						$('#admin_user_addDialog').dialog('close');
					}else{
						alert("用户已经存在");
					}
				},
				error: function() {
					alert('注册失败');
				}
			});
		}
	</script>

	<div id="admin_book_layout" class="easyui-layout" data-options="fit:true,border:false">
		<div data-options="region:'north',title:'查询条件',border:false" style="height: 70px;">
			<form id="admin_product_searchForm">
				检索用户(可模糊查询):<input name="sectionName" /> </a> <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="proSearchFun()">查询</a> <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-back'" onclick="proClearFun()">清空</a>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table id="admin_user_datagrid" data-options="border:false"></table>
		</div>

	</div>

	<div id="admin_user_addDialog" class="easyui-dialog"
		 data-options="closed:true,modal:true,title:'添加用户',buttons:[{
					text : '添加',
					iconCls : 'icon-add',
					handler : function() {
                        registerUser();
					}}]"
		 style="width: 280px; height: 315px;" title="添加用户">
		<form id="admin_user_addForm" method="post">
			<table>
				<tr>
					<th>用户名</th>
					<td><input name="username" class="easyui-validatebox"
							   data-options="required:true" style="width: 100%" /></td>
				</tr>
				<tr>
					<th>密码</th>
					<td><input name="password" class="easyui-validatebox"
							   data-options="required:true" style="width: 100%" /></td>
				</tr>
				<tr>
					<th>所属组织</th>
					<td><select id="org-select" data-options="multiple:true,panelHeight:'auto'" class="esayui-combobox"  name="organization" style="width: 100%"/></td>
				</tr>
				<tr>
					<th>角色列表</th>
					<td><select  id="role-select" data-options="multiple:true,panelHeight:'auto'" class="esayui-combobox"  name="roleIds" style="width: 100%"/></td>
				</tr>
				<tr>
					<th>邮箱</th>
					<td><input name="email" class="easyui-validatebox" style="width: 100%"/></td>
				</tr>
				<tr>
					<th>名字</th>
					<td><input name="nickname" class="easyui-validatebox" style="width: 100%"/></td>
				</tr>
				<tr>
					<th>账户金额</th>
					<td><input name="account" class="easyui-validatebox" style="width: 100%"/></td>
				</tr>
				<tr>
					<th>是否启用</th>
					<td><input name="locked" class="easyui-validatebox" style="width: 100%"/></td>
				</tr>

				<tr align="center">

				</tr>

			</table>
		</form>
	</div>

	<div id="mydialog-e"></div>
</body>
</html>
