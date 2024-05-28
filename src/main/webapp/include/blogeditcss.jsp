<style>
	@font-face {
	    font-family: 'Pretendard-Thin';
	    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Thin.woff') format('woff');
	    font-weight: 100;
	    font-style: normal;
	}
	@font-face {
	    font-family: 'Pretendard-ExtraLight';
	    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-ExtraLight.woff') format('woff');
	    font-weight: 200;
	    font-style: normal;
	}
	@font-face {
	    font-family: 'Pretendard-Light';
	    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Light.woff') format('woff');
	    font-weight: 300;
	    font-style: normal;
	}
	@font-face {
	    font-family: 'Pretendard-Regular';
	    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
	    font-weight: 400;
	    font-style: normal;
	}
	@font-face {
	    font-family: 'Pretendard-Medium';
	    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Medium.woff') format('woff');
	    font-weight: 500;
	    font-style: normal;
	}
	@font-face {
	    font-family: 'Pretendard-SemiBold';
	    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-SemiBold.woff') format('woff');
	    font-weight: 600;
	    font-style: normal;
	}
	@font-face {
	    font-family: 'Pretendard-Bold';
	    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Bold.woff') format('woff');
	    font-weight: 700;
	    font-style: normal;
	}
	@font-face {
	    font-family: 'Pretendard-ExtraBold';
	    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-ExtraBold.woff') format('woff');
	    font-weight: 800;
	    font-style: normal;
	}
	@font-face {
	    font-family: 'Pretendard-Black';
	    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Black.woff') format('woff');
	    font-weight: 900;
	    font-style: normal;
	}
	.font-light {font-family: 'Pretendard-Light';}
	.font-semiBold {font-family: 'Pretendard-SemiBold';}
	.font-bold {font-family: 'Pretendard-Bold';}
	body {
		font-family: 'Pretendard-Medium';
		cursor: default;
	}
	.body-layout {
		display: grid;
		grid-template-areas: 'header' 'content' 'footer';
		grid-template-rows: 90px 1fr 100px;
	}
	.menu-title {
		grid-area: header;
		display: flex;
 		padding: 20px 30px;
 		justify-content: space-between;
	}
	main {
		grid-area: content;
		background-color: #F6F6F6;
		border-top: 1px solid #a6a6a6;
	}
	.container {
		display: flex;
		padding-top: 50px;
		gap: 50px;
	}
	.sidebar {
	    width: 250px;
	}
	
	.profile {
	    text-align: center;
	    margin-bottom: 20px;
	   	background-color: #fff;
	    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
	}
	
	.profile-img {
	    width: 100%;
	    height: 100%;
	    object-fit: cover;
	    border-bottom: 1px solid #a6a6a6;
	}
	
	.profile-name {
	    font-size: 18px;
	    font-weight: bold;
	    margin: 10px 0 0;
	    padding: 10px;
	    cursor: pointer;
	}
	
	.profile-link {
	    font-size: 14px;
	    color: #888;
	    padding: 10px 30px 30px;
	}
	
	.write-button {
	    width: 100%;
	    padding: 10px;
	    background-color: #333;
	    color: #fff;
	    border: none;
	    cursor: pointer;
	    margin-bottom: 20px;
	}
	nav {
		background-color: #fff;
	    padding: 20px;
	    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
	}
	nav ul {
	    list-style: none;
	    padding: 0;
	}
	.parent-li {
		font-size: 19px;
		margin-left: 0;
		cursor: default;
	}
	nav ul li {
	    cursor: pointer;
	    margin-left: 30px;
	    padding: 3px;
	    font-size: 14px;
	}
	
	nav ul li.active {
	    color: red;
	}
	
	.main-content {
	    flex-grow: 1;
	}
	
	h1 {
	    font-size: 24px;
	    margin-bottom: 10px;
	}
	.category-box {
		margin-top: 20px;
		padding: 20px;
		background-color: rgba(140, 194, 225, 0.13);
		border-radius: 5px;
	}
	.selected {
	    background-color: rgba(140, 194, 225, 0.3);
	}
	.list-group-child {
		margin-left: 20px;
	}
	.category-manager {
	    border: 1px solid #ddd;
	    background-color: #fff;
	    padding: 30px;
	}
	
	.category-list {
	    flex-grow: 1;
	}
	
	.category {
	    padding: 10px;
	    border-bottom: 1px solid #ddd;
	}
	.parent-category {
		margin-bottom: 10px;
		list-style: none;
		padding-top: 5px;
	}
	.subcategory {
	    padding: 10px 20px;
	    background-color: #f1f1f1;
	    border-bottom: 1px solid #ddd;
	}
	
	.add-category {
	    margin-top: 10px;
	    padding: 10px;
	    background-color: #007BFF;
	    color: #fff;
	    border: none;
	    cursor: pointer;
	}
	
	.category-settings {
	    width: 200px;
	}
	
	.category-settings input {
	    width: 100%;
	    padding: 5px;
	    margin: 10px 0;
	}
	
	.category-settings button {
	    width: 100%;
	    padding: 10px;
	    background-color: #28a745;
	    color: #fff;
	    border: none;
	    cursor: pointer;
	}
	.category-btns {
		display: flex;
		justify-content: space-between;
	}
	a:link {
  	color : gray;
	}
	a:visited {
	  color : gray;
	}
	a:hover {
	  color : #ff7200;
	  text-decoration-line: none;
	}
	a:active {
	  color : #ff7200;
	}
	.footer {
		grid-area: footer;
		background-color: #F6F6F6;
    	display: flex;
    	justify-content: center;
    	align-items: center;
	}
	.orangeBtn{
		font-family: 'Pretendard-Light';
		display: inline-block;
		outline: none;
		cursor: pointer;
		font-size: 15px;
		line-height: 1;
		border-radius: 500px;
		transition-property: background-color,border-color,color,box-shadow,filter;
		transition-duration: .3s;
		border: 1px solid transparent;
		letter-spacing: 2px;
		min-width: 160px;
		text-transform: uppercase;
		white-space: normal;
		font-weight: 700;
		text-align: center;
		padding: 16px 14px 18px;
		color: #fff;
		background-color: #ff7200;
		height: 48px;
	}
	.orangeBtn-sm{
		font-family: 'Pretendard-Light';
		display: inline-block;
		outline: none;
		cursor: pointer;
		font-size: 13px;
		line-height: 1;
		border-radius: 500px;
		transition-property: background-color,border-color,color,box-shadow,filter;
		transition-duration: .3s;
		border: 1px solid transparent;
		letter-spacing: 2px;
		min-width: 120px;
		text-transform: uppercase;
		white-space: normal;
		font-weight: 600;
		text-align: center;
		padding: 14px 14px 18px;
		color: #fff;
		background-color: #ff7200;
		height: 42px;
		margin-top: 5px;
	}
	.grayBtn{
		font-family: 'Pretendard-Light';
		display: inline-block;
		outline: none;
		cursor: pointer;
		font-size: 15px;
		line-height: 1;
		border-radius: 500px;
		transition-property: background-color,border-color,color,box-shadow,filter;
		transition-duration: .3s;
		border: 1px solid transparent;
		letter-spacing: 2px;
		min-width: 160px;
		text-transform: uppercase;
		white-space: normal;
		font-weight: 700;
		text-align: center;
		padding: 16px 14px 18px;
		color: gray;
		background-color: #eee;
		height: 48px;
	}
	i{
		cursor: pointer;
	}
	.orangeBtn:hover, .orangeBtn-sm:hover{
	    background-color: #afeeee;
	    color: gray;
	}
	.grayBtn:hover{
	    background-color: #ddd;
	}
	.menu-right-bar {
		display: flex;
		align-items:flex-start;
		justify-content: center;
		gap: 40px;
	}
	body::-webkit-scrollbar {
	    width: 10px;  
	}
	
	body::-webkit-scrollbar-thumb {
	    background: #ff7200;
	    border-radius: 10px;
	    height: 30px;
	}
	
	body::-webkit-scrollbar-track {
	    background: #afeeee;
	}
	.user-profile {
		margin-right: 30px;
	}
	.user-profile img {
		width: 50px;
		height: 50px;
		object-fit: cover;
		border-radius: 50%;
		cursor: pointer;
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
	.proBtn-sm {
		padding: 2px 5px;
		border: 1px solid #ccc;
		background-color: #fff;
		cursor: pointer;
		color: #747474;
		font-size: 12px;
	}
	.proBtn-sm:active {
		padding: 2px 5px;
		border: 1px solid #ccc;
		background-color: #eee;
		cursor: pointer;
		color: #747474;
		font-size: 12px;
	}
	.edit-btns {
	    position: absolute;
	    top: 50%;
	    right: 10px;
	    transform: translateY(-50%);
	    display: none;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	.content-list{
		text-align: center;
	}
	.orangeBtn{
		font-family: 'Pretendard-Light';
		display: inline-block;
		outline: none;
		cursor: pointer;
		font-size: 15px;
		line-height: 1;
		border-radius: 500px;
		transition-property: background-color,border-color,color,box-shadow,filter;
		transition-duration: .3s;
		border: 1px solid transparent;
		letter-spacing: 2px;
		min-width: 160px;
		text-transform: uppercase;
		white-space: normal;
		font-weight: 700;
		text-align: center;
		padding: 16px 14px 18px;
		color: #fff;
		background-color: #ff7200;
		height: 48px;
	}
	.orangeBtn-sm{
		font-family: 'Pretendard-Light';
		display: inline-block;
		outline: none;
		cursor: pointer;
		font-size: 13px;
		line-height: 1;
		border-radius: 500px;
		transition-property: background-color,border-color,color,box-shadow,filter;
		transition-duration: .3s;
		border: 1px solid transparent;
		letter-spacing: 2px;
		min-width: 120px;
		text-transform: uppercase;
		white-space: normal;
		font-weight: 600;
		text-align: center;
		padding: 14px 14px 18px;
		color: #fff;
		background-color: #ff7200;
		height: 42px;
		margin: 0 10px;
	}
	.grayBtn{
		font-family: 'Pretendard-Light';
		display: inline-block;
		outline: none;
		cursor: pointer;
		font-size: 15px;
		line-height: 1;
		border-radius: 500px;
		transition-property: background-color,border-color,color,box-shadow,filter;
		transition-duration: .3s;
		border: 1px solid transparent;
		letter-spacing: 2px;
		min-width: 160px;
		text-transform: uppercase;
		white-space: normal;
		font-weight: 700;
		text-align: center;
		padding: 16px 14px 18px;
		color: gray;
		background-color: #eee;
		height: 48px;
	}
	i{cursor: pointer;}
	.orangeBtn:hover, .orangeBtn-sm:hover{
	    background-color: #afeeee;
	    color: gray;
	}
	.grayBtn:hover{
	    background-color: #ddd;
	}
	.menu-right-bar {
		display: flex;
		align-items:flex-start;
		justify-content: center;
		gap: 40px;
	}
	body::-webkit-scrollbar {
	    width: 10px;  
	}
	
	body::-webkit-scrollbar-thumb {
	    background: #ff7200;
	    border-radius: 10px;
	    height: 30px;
	}
	
	body::-webkit-scrollbar-track {
	    background: #afeeee;
	}
	.login-title-text{
		font-size: 24pt;
		color: gray;
		margin: 100px 0;
	}
	.main-blog{
		color: gray;
	}
	.active-color {color: #ff7200!important;}
	.content-bt{
		padding: 0px 50px 50px 50px;
	}
	.content-box{
		width: 76%;
		padding: 30px;
		margin: 0 auto;
		display: flex;
		gap: 50px;
	}
	.content-box h3{
		font-family: 'Pretendard-Bold';
		color: #ff7200;
	}
	.content-box .blog-user-info{
		color: gray;
		font-size: 13pt;
	}
	.content-box .blog-date {
		color: #D5D5D5;
		font-family: 'Pretendard-Light';
	}
	.content-box > .text-box{
		display: flex;
		flex-direction: column;
	}
	.content-box-line {width:74%;}
	.content-text {
		overflow: hidden;
		text-overflow: ellipsis;
		display: -webkit-box;
		-webkit-line-clamp: 4;
		-webkit-box-orient: vertical;
		color: #747474;
		font-family: 'Pretendard-Light';
	}
	input {
	    font-family: 'Pretendard-Light';
	}
	.imgBox {
		width: 200px;
		height: 200px;
		flex-shrink: 0;
	}
	.imgBox img{
	    width: 100%;
        height: 100%;
		object-fit: cover;
	}
	.user-profile {
		margin-right: 30px;
	}
	.user-profile img {
		width: 50px;
		height: 50px;
		object-fit: cover;
		border-radius: 50%;
		cursor: pointer;
	}
	.header_layer {
	    position: absolute;
	    top: 84px;
	    right: 30px;
	    width: 300px;
	    border-radius: 3px;
	    background-color: #fff;
	    box-sizing: content-box;
	    box-shadow: 0 2px 5px rgba(0, 0, 0, .1), 0 0 1px rgba(0, 0, 0, .3);
	    text-align: left;
	}
	.header_layer:after {
	    content: "";
	    position: absolute;
	    top: -8px;
	    right: 24px;
	    width: 16px;
	    height: 9px;
	    background-image: url(https://t1.daumcdn.net/tistory_admin/static/top/pcrtn/layer_edge.png);
	    background-size: 16px 9px;
	}
	.layer_news {
	    top: 85px;
	    right: 128px;
	    width: 400px;
	    z-index: 99;
	}
	.layer_profile {
		top: 85px;
	    right: 53px;
	    width: 250px;
	    padding: 20px;
	    font-family: 'Pretendard-Light';
	    z-index: 99;
	}
	.sub-main{
		margin: 100px 0;
		font-size: 24pt;
	}
	.sub-blogs{
		width: 90%;
		display: flex;
		justify-content: center;
		gap: 50px;
		margin: 50px auto;
		flex-wrap: wrap;
	}
	.sub-blog{
		width: 17%;
		display: flex;
		flex-wrap: wrap;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		padding: 50px;
		box-sizing: content-box;
	    box-shadow: 0 2px 5px rgba(0, 0, 0, .1), 0 0 1px rgba(0, 0, 0, .3);
	    color: gray;
	    gap: 10px;
	}
	.sub-blog img {
		width: 100px;
		height: 100px;
		border-radius: 50%;
		margin-bottom: 20px;
	}
	.blog-title {
		font-family: 'Pretendard-Bold';
		font-size: 16pt;
	}
	.blog-ment {
		height: 50px;
		overflow: hidden;
		text-overflow: ellipsis;
		display: -webkit-box;
		-webkit-line-clamp: 2;
		-webkit-box-orient: vertical;
		font-family: 'Pretendard-Light';
		color: #747474;
	}
	
	.layer_profile_header {
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	    margin-bottom: 6px;
	    color: #666;
	    
	}
	
	.layer_profile_username {
	    font-size: 18px;
	    font-family: 'Pretendard-Medium';
	}
	.u-mail_u-account {
		display: flex;
		justify-content: space-between;
		margin-bottom: 10px;
	}
	.layer_profile_email {
	    color: #A6A6A6;
	    font-size: 14px;
	}
	
	.layer_profile_account-management {
	    color: #A6A6A6;
	    cursor: pointer;
	    font-size: 14px;
	}
	.user_blogs {
	    margin-bottom: 20px;
	}
	
	.user_blog {
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	}
	.b-title {
		font-size: 12px;
		margin-bottom: 5px;
		color: #A6A6A6;
	}
	.user_blog-title {
	    font-size: 16px;
	    color: #747474;
	    cursor: pointer;
	}
	
	.user_write-icon, .user_settings-icon {
	    margin-left: 10px;
	    color: #888;
	    cursor: pointer;
	}
	.user_logout {
		font-size: 12px;
	    color: #A6A6A6;
	    cursor: pointer;
	}
	
	
	
	.notification-top {
		padding: 10px;
	}
	.notification-hr {
	    margin: 0;
	}
	
	.notification-header {
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	    gap: 10px;
	}
	
	.notification-list {
	    width: 400px;
	    height: 400px;
	    overflow-y: auto;
	    overflow-x: hidden;
	}
	
	.notification {
	    display: flex;
	    align-items: flex-start;
	    padding: 10px;
	    border-bottom: 1px solid #eee;
	    cursor: pointer;
	    background-color: white;
	    transition: background-color 0.3s;
	}
	
	.notification:hover {
	    background-color: #f0f0f0;
	}
	
	.notification.clicked {
	    background-color: #ddd;
	}
	
	.profile-pic {
	    width: 50px;
	    height: 50px;
	    border-radius: 50%;
	    margin: 10px;
	}
	
	.notification-content {
	    display: flex;
	    flex-direction: column;
	    justify-content: center;
	    padding: 10px;
	    font-size: 11pt;
	}
	.user {
	    margin: 0;
	}
	.user-name {
	    color: #ff7200;
	}
	.comment {
		margin-bottom: 10px;
	}
	.date {
	    font-size: 0.8em;
	    color: gray;
	    margin: 0;
	}
	.title {
		font-family: 'Pretendard-Light';
		margin: 0;
		color: #A6A6A6;
	}
	.btn-gray {
		background-color: #eee;
		color: gray;
		border: none;
	}
	.btn-gray:hover {
		background-color: #ddd;
		color: gray;
	}
	#modalText {
		font-family: 'Pretendard-Light';
	}
	#error-name {
		display: none;
		color: red;
		font-size: 13px;
	}
</style>