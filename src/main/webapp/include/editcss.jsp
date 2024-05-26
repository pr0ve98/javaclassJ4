<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.body-layout {
		display: grid;
		grid-template-areas: 'header' 'content';
		grid-template-rows: 100px 1fr;
	}
	.navbar-brand {
		margin: 0 auto;
	}
	.content-list {
		width: 30%;
		padding: 30px;
		margin: 50px auto 100px;
		box-sizing: content-box;
	    box-shadow: 0 2px 5px rgba(0, 0, 0, .1), 0 0 1px rgba(0, 0, 0, .3);
	}
	.table-label{
		width: 30%;
		vertical-align: middle!important;
		background-color: #eee;
	}
	.table-content{
		width: 70%;
	}
	.user-profile {
		margin: 0 auto 20px;
	}
	.user-profile img {
		width: 100px;
		height: 100px;
		cursor: default;
	}
	.proBtn {
		padding: 5px 10px;
		border: 1px solid #ccc;
		background-color: #fff;
		cursor: pointer;
		color: #747474;
	}
	.proBtn:active {
		padding: 5px 10px;
		border: 1px solid #ccc;
		background-color: #eee;
		cursor: pointer;
		color: #747474;
	}
</style>