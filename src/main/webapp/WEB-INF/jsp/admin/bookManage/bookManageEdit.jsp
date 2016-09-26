<%@ page language="java" pageEncoding="UTF-8"%>

<form id="admin_productEdit_editForm" method="post">
	<table>
		<input name="id" hidden="true" />
		<input name="status" hidden="true" />
		<tr>
			<th>商品名</th>
			<td><input name="productName" style="width:80%" class="easyui-validatebox" data-options="required:true" />
			</td>
		</tr>
		<tr>
			<th>描述</th>
			<td><textarea name="description" style="width:80%" class="easyui-validatebox" data-options="required:true"></textarea>
			</td>
		</tr>
		<tr>
			<th>原价</th>
			<td><input name="fixedPrice" style="width:80%" class="easyui-validatebox" data-options="required:true" />
			</td>
		</tr>
		<tr>
			<th>特惠</th>
			<td><input name="dangPrice" style="width:80%" class="easyui-validatebox" data-options="required:true" />
			</td>
		</tr>
		<tr>
			<th>关键词</th>
			<td><input name="keywords" style="width:80%" class="easyui-validatebox" data-options="required:true" />
			</td>
		</tr>		
		<tr>
			<th>数量</th>
			<td><input name="productNum" style="width:80%" class="easyui-validatebox" data-options="required:true" />
			</td>
		</tr>
		<tr>
			<th>状态</th>
			<td><input name="hasDeleted" style="width:80%" class="easyui-validatebox" data-options="required:true" />
			</td>
		</tr>
		<tr>
			<th>图片</th>
			<td>
			    <input  id="productPic" name="productPic" style="width:80%" class="easyui-validatebox" data-options="required:true" />	
			</td>
		</tr>
	</table>
	
</form>

<table>
	    <tr>
	        <td width="80px"></td>	
			<td style="word-break:break-all;padding-left: 10px;">
			  <form id="admin_proManage_importDialog">
			    <input type="file" id="uploadfile" name="file" /><a id="btn" href="#" class="easyui-linkbutton" onclick="xsImport()" data-options="iconCls:'icon-add'">导入</a>
			  </form>
			</td>	
		</tr>
</table>