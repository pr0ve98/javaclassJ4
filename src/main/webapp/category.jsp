<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Category Reordering</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.14.0/Sortable.min.js"></script>
    <style>
        .list-group-item {
            cursor: move;
        }
        .selected {
            background-color: #f0f0f0;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h2>Reorder Categories</h2>
        <button id="add-category" class="btn btn-primary mb-3">Add Category</button>
        <ul class="list-group" id="category-list">
            <li class="parent-category">
                <strong>Parent Category 1</strong>
                <ul class="list-group mt-2" id="parent-1">
                    <li class="list-group-item" data-id="1">Child Category 1</li>
                    <li class="list-group-item" data-id="2">Child Category 2</li>
                    <li class="list-group-item" data-id="3">Child Category 3</li>
                </ul>
            </li>
            <li class="parent-category">
                <strong>Parent Category 2</strong>
                <ul class="list-group mt-2" id="parent-2">
                    <li class="list-group-item" data-id="4">Child Category 4</li>
                    <li class="list-group-item" data-id="5">Child Category 5</li>
                    <li class="list-group-item" data-id="6">Child Category 6</li>
                </ul>
            </li>
        </ul>
    </div>

    <script>
        let selectedParent = null;

        // 부모 카테고리 선택
        $(document).on('click', '.parent-category', function(e) {
            if(selectedParent) {
                $(selectedParent).removeClass('selected');
            }
            selectedParent = this;
            console.log(selectedParent);
            $(this).addClass('selected');
            event.stopPropagation();
        });

        // 부모 카테고리 외 다른부분 클릭시 부모카테고리 클릭 속성 삭제
        $(document).on('click', function(e) {
            if (selectedParent && !$(event.target).closest('.parent-category').length) {
                $(selectedParent).removeClass('selected');
                selectedParent = null;
            }
        });

        // 카테고리 추가 부분
        $('#add-category').click(function() {
            if (!selectedParent) {
                const newParentId = 'parent-' + (new Date().getTime());
                const newParentHtml = `
                    <li class="parent-category">
                        <strong>New Parent Category</strong>
                        <ul class="list-group mt-2" id="${newParentId}"></ul>
                    </li>
                `;
                $('#category-list').append(newParentHtml);
                new Sortable(document.getElementById(newParentId), sortableOptions);
            } else {
                const newChildId = 'child-' + (new Date().getTime());
                const newChildHtml = `<li class="list-group-item" data-id="${newChildId}">New Child Category</li>`;
                $(selectedParent).find('.list-group').append(newChildHtml);
            }
        });

        // Sortable 옵션 설정
        const sortableOptions = {
            animation: 150,
            onEnd: function (evt) {
                const parentId = evt.to.id;
                const order = [];
                const items = evt.to.children;
                for (let i = 0; i < items.length; i++) {
                    order.push(items[i].dataset.id);
                }
                console.log('New order for ' + parentId + ':', order);
                updateOrder(parentId, order);
            }
        };

        // Sortable 초기화
        new Sortable(document.getElementById('parent-1'), sortableOptions);
        new Sortable(document.getElementById('parent-2'), sortableOptions);

        function updateOrder(parentId, order) {
            $.ajax({
                url: '/saveOrder',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ parentId: parentId, order: order }),
                success: function(response) {
                    console.log('Order saved for ' + parentId + ':', response);
                },
                error: function(xhr, status, error) {
                    console.error('Error saving order for ' + parentId + ':', error);
                }
            });
        }
    </script>
</body>
</html>
