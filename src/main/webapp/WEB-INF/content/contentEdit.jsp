<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${bVo.blogTitle} - 글 수정</title>
<link rel="icon" type="image/x-icon" href="${ctp}/images/favicon.ico">
<%@ include file="/include/bs4.jsp"%>
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<%@ include file="/include/blogInputcss.jsp"%>
<style>
	@font-face {
		font-family: '나눔바른고딕';
		font-style: normal;
		font-weight: 400;
		src:
			url('//fastly.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.eot');
		src:
			url('//fastly.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.eot?#iefix')
			format('embedded-opentype'),
			url('//fastly.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.woff')
			format('woff'),
			url('//fastly.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.ttf')
			format('truetype');
	}
	
	@font-face {
		font-family: '리디바탕';
		src:
			url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_twelve@1.0/RIDIBatang.woff')
			format('woff');
		font-weight: normal;
		font-style: normal;
	}
	
	@font-face {
		font-family: '서울남산체';
		src:
			url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_two@1.0/SeoulNamsanM.woff')
			format('woff');
		font-weight: normal;
		font-style: normal;
	}
	
	@font-face {
		font-family: '둘기마요고딕';
		src:
			url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.1/Dovemayo_gothic.woff2')
			format('woff2');
		font-weight: normal;
		font-style: normal;
	}
	
	@font-face {
		font-family: '매일옥자체';
		src:
			url('https://fastly.jsdelivr.net/gh/projectnoonnu/2403@1.0/Ownglyph_Dailyokja-Rg.woff2')
			format('woff2');
		font-weight: normal;
		font-style: normal;
	}
	
	@font-face {
		font-family: '밑미폰트';
		src:
			url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2402_1@1.0/Ownglyph_meetme-Rg.woff2')
			format('woff2');
		font-weight: normal;
		font-style: normal;
	}
	
	#editor-container {
		width: 100%;
		margin: 0 auto;
	}
	
	.note-editable {
		margin: 10px;
		font-family: '나눔바른고딕', '리디바탕', '서울남산체', '둘기마요고딕', '매일옥자체', '밑미폰트',
			sans-serif;
		background-color: #fff;
	}
	
	input[type="text"] {
		font-size: 24px;
	}
	.note-editable img {
	    max-width: 100%;
	    height: auto;
	}
</style>
<script>
	'use strict';
	
	// 작성 버튼
	function editBtn() {
	    let writeHeaderLayer = document.querySelector('.menu-right-bar .layer_write');
	
	    // 작성 버튼의 header_layer가 없는 경우 생성
	    if (!writeHeaderLayer) {
	        let headerLayer = document.createElement('div');
	        headerLayer.className = 'header_layer layer_write';
	        headerLayer.innerHTML = '<div class="layer_write_header">'
	        	+'<form id="contentInputForm" method="post">'
		        +'<table class="table table-borderless text-center">'
		        +'<tr><td class="table-label">카테고리</td>'
		        +'<td class="table-content">'
		        +'<select name="category" id="category" class="custom-select">'
		        +'<c:forEach var="cPVo" items="${cPVos}">'
		        +'<option value="${cPVo.caIdx}" ${contentVo.categoryIdx == cPVo.caIdx ? "selected" : ""}>${cPVo.category}</option>'
		        +'<c:forEach var="cCVo" items="${cCVos}">'
		        +'<c:if test="${cCVo.parentCategoryIdx == cPVo.caIdx}">'
		        +'<option value="${cCVo.caIdx}" ${contentVo.categoryIdx == cCVo.caIdx ? "selected" : ""}>&nbsp;-&nbsp;${cCVo.category}</option>'
		        +'</c:if></c:forEach></c:forEach>'
		        +'</td></tr>'
		        +'<tr><td class="table-label">주제</td>'
		        +'<td class="table-content">'
		        +'<select name="part" id="part" class="custom-select">'
		        +'<option value="없음" ${contentVo.part == "없음" ? "selected" : ""}>주제 선택 안 함</option>'
		        +'<option ${contentVo.part == "일상" ? "selected" : ""}>일상</option>'
		        +'<option ${contentVo.part == "취미" ? "selected" : ""}>취미</option>'
		        +'<option ${contentVo.part == "영화/드라마" ? "selected" : ""}>영화/드라마</option>'
		        +'<option ${contentVo.part == "게임" ? "selected" : ""}>게임</option>'
		        +'<option ${contentVo.part == "패션/미용" ? "selected" : ""}>패션/미용</option>'
		        +'<option ${contentVo.part == "비즈니스/경제" ? "selected" : ""}>비즈니스/경제</option>'
		        +'<option ${contentVo.part == "육아/결혼" ? "selected" : ""}>육아/결혼</option>'
		        +'<option ${contentVo.part == "문학/책" ? "selected" : ""}>문학/책</option>'
		        +'<option ${contentVo.part == "반려동물" ? "selected" : ""}>반려동물</option>'
		        +'<option ${contentVo.part == "여행" ? "selected" : ""}>여행</option>'
		        +'<option ${contentVo.part == "상품리뷰" ? "select" : ""}>상품리뷰</option>'
		        +'</td></tr>'
		        +'<tr><td class="table-label">공개 설정</td>'
		        +'<td class="table-content">'
		        +'<input type="radio" name="publicSetting" id="publicSetting1" value="공개" ${contentVo.coPublic == "공개" ? "checked" : ""}/>&nbsp;공개&nbsp; &nbsp;&nbsp; &nbsp;'
		        +'<input type="radio" name="publicSetting" id="publicSetting2" value="비공개" ${contentVo.coPublic == "비공개" ? "checked" : ""}/>&nbsp;비공개'
		        +'</td></tr>'
		        +'<tr><td colspan="2" style="margin:0 auto;">'
		        +'<input type="button" class="mt-2 proBtn" value="작성" onclick="editContent()">'
		        +'</td></tr>'
				+'</table>'
				+'<input type="hidden" name="hostIp" id="hostIp" value="${pageContext.request.remoteAddr}" />'
				+'<input type="hidden" name="coIdx" id="coIdx" value="${coIdx}" />'
				+'</form>'
	        	+'</div>';
	        document.querySelector('.menu-right-bar').appendChild(headerLayer);
	        document.addEventListener('click', handleClickOutsideWrite);
	    } else { // 작성 버튼의 header_layer가 있는 경우 제거
	    	writeHeaderLayer.remove();
	        document.removeEventListener('click', handleClickOutsideWrite);
	    }
	}
	
	function handleClickOutsideWrite(e) {
	    let writeHeaderLayer = document.querySelector('.menu-right-bar .layer_write');
	    if (writeHeaderLayer && !writeHeaderLayer.contains(e.target) && !e.target.matches('.menu-right-bar *')) {
	    	writeHeaderLayer.remove();
	        document.removeEventListener('click', handleClickOutsideWrite);
	    }
	}
</script>
</head>
<body class="body-layout">
	<div class="menu-title">
		<a class="navbar-brand" href="${ctp}/Main"><img
			src="${ctp}/images/logo.png" alt="logo" style="width: 200px;"></a>
		<div class="menu-right-bar">
			<button class="grayBtn-sm" onclick="history.back()">취소</button>
			<button class="orangeBtn-sm" onclick="editBtn()">수정</button>
		</div>
	</div>
	<main>
		<div class="container">
			<div id="editor-container">
				<form id="postForm" method="post">
					<input type="text" name="title" id="title" value="${contentVo.title}" class="form-control mb-3" />
					<textarea id="summernote" name="content"></textarea>
				</form>
			</div>
		</div>
	</main>

	<!-- Summernote JS -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>

	<!-- The Modal -->
	<div class="modal fade" id="myModal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title" id="modalTitle"></h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<div id="modalText"></div>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary btn-gray"
						data-dismiss="modal">닫기</button>
				</div>

			</div>
		</div>
	</div>

	<script>
	let initialImages = [];
	let imgs = '${contentVo.imgName}'.split("|");
	for(let i=0; i<imgs.length; i++){
		if(imgs[i].indexOf("http") == -1){
			initialImages.push("${ctp}/images/content/"+imgs[i]);
		}
	}
	let currentImages = [];

	// 썸머노트 기본설정
	$(document).ready(function() {
		$("#summernote").html('${contentVo.content}');
	    let fontList = ['나눔바른고딕', '리디바탕', '서울남산체', '둘기마요고딕', '매일옥자체', '밑미폰트'];
	    $('#summernote').summernote({
	        lang: 'ko-KR',
	        tabsize: 2,
	        height: 700,
	        toolbar: [
	            ['fontname', ['fontname']],
	            ['fontsize', ['fontsize']],
	            ['style', ['bold', 'italic', 'underline', 'strikethrough', 'clear']],
	            ['color', ['forecolor', 'color']],
	            ['para', ['ul', 'ol', 'paragraph']],
	            ['insert', ['picture', 'video']],
	            ['view', ['help']]
	        ],
	        fontNames: fontList,
	        fontNamesIgnoreCheck: fontList,
	        fontSizes: ['10', '11', '12', '14', '16', '18', '20', '22', '24'],
	        callbacks: {
	            onInit: function() {
	                // 초기 내용 저장
	                initialContent = $('#summernote').summernote('code');
	                $('.note-editable').css('font-family', '나눔바른고딕');
	            },
	            onImageUpload: function(files) {
	                if (files.length > 0) {
	                    for (let i = 0; i < files.length; i++) {
	                        uploadImage(files[i]);
	                    }
	                }
	            }
	        }
	    });
	});

		// 이미지 업로드
	    function uploadImage(file) {
			let fileSize = file.size;
			let maxSize = 1024 * 1024 * 10;
			
			const imgType = ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'];
			if(imgType.indexOf(file.type) == -1){
                $("#myModal #modalTitle").text("파일 오류");
                $("#myModal #modalText").text("이미지 파일만 업로드해주세요!");
                $('#myModal').modal('show');
                return;
			}
			if(fileSize > maxSize) {
                $("#myModal #modalTitle").text("파일 오류");
                $("#myModal #modalText").text("파일의 최대 크기는 10MB입니다!");
                $('#myModal').modal('show');
                return;
			}
	        let data = new FormData();
	        data.append("file", file);

	        $.ajax({
	            url: '${ctp}/ContentImageUpload',
	            cache: false,
	            contentType: false,
	            processData: false,
	            data: data,
	            type: "POST",
	            success: function(response) {
                    $('#summernote').summernote('insertImage', response, function($image) {
                        initialImages.push(response);
                    });
	            },
	            error: function() {
	                $("#myModal #modalTitle").text("전송 오류");
	                $("#myModal #modalText").text("전송 오류!");
	                $('#myModal').modal('show');
	            }
	        });
	    }

	    // 현재 창에 있는 이미지 가져오기
	    function getCurrentImages() {
	        return $('#summernote').next('.note-editor').find('.note-editable img').map(function() {
	            return $(this).attr('src');
	        }).get();
	    }

	    // 이미지 삭제 실행함수
	    function detectDeletedImages(initialImages, currentImages) {
	        initialImages.forEach(function(src) {
	            if (!currentImages.includes(src)) {
	                deleteImage(src);
	            }
	        });
	    }

	    // 이미지 삭제 ajax
	    function deleteImage(src) {
	        $.ajax({
	            url: '${ctp}/ContentImageDelete',
	            type: 'POST',
	            data: { src: src },
	            error: function() {
	                console.log('이미지 삭제 실패');
	            }
	        });
	    }

	    // 글 수정
	    function editContent() {
	        let mid = $('#mid').val();
	        let title = $('#title').val().trim();
	        let content = $('#summernote').summernote('code').trim();
	        let category = $('#category').val();
	        let part = $('#part').val();
	        let hostIp = $('#hostIp').val();
	        let publicSetting = $('input[name="publicSetting"]:checked').val();
	        let coIdx = $('#coIdx').val();

	        if (title == '') {
	            $("#myModal #modalTitle").text("글 제목");
	            $("#myModal #modalText").text("글 제목을 입력하세요!");
	            $('#myModal').modal('show');
	            $('#myModal').on('hide.bs.modal', function() {
	                $('#title').focus();
	            });
	            return false;
	        }

	        if (content == '' || content == '<p><br></p>') {
	            $("#myModal #modalTitle").text("글 내용");
	            $("#myModal #modalText").text("글 내용을 입력하세요!");
	            $('#myModal').modal('show');
	            $('#myModal').on('hide.bs.modal', function() {
	                $('#summernote').focus();
	            });
	            return false;
	        }
	        
	        let query = {
	            title: title,
	            content: content,
	            category: category,
	            part: part,
	            hostIp: hostIp,
	            publicSetting: publicSetting,
	            coIdx: coIdx
	        };

	        $.ajax({
	            url: "${ctp}/ContentEditOk",
	            type: "post",
	            data: query,
	            success: function(res) {
	            	let r = res.split("/");
	            	let categoryIdx = parseInt(r[1]);
	                if (r[0] != "0") {
	                    currentImages = getCurrentImages();
	                    detectDeletedImages(initialImages, currentImages);
	                    initialImages = [...currentImages];
	                    location.href = "${ctp}/content/${sMid}?coIdx=${coIdx}&categoryIdx="+categoryIdx;
	                } else {
	                    $("#myModal #modalTitle").text("작성 오류");
	                    $("#myModal #modalText").text("게시글 등록 실패!");
	                    $('#myModal').modal('show');
	                }
	            },
	            error: function() {
	                $("#myModal #modalTitle").text("전송 오류");
	                $("#myModal #modalText").text("전송 오류!");
	                $('#myModal').modal('show');
	            }
	        });
	    }
	    
  </script>
</body>
</html>