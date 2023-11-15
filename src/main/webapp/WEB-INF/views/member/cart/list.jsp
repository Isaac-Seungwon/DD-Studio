<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/inc/asset.jsp"%>
<link rel="stylesheet" href="/ddstudio/asset/css/main.css">
<style>
#main>#title, .item div {
	background-color: white;
}

.name {
	font-weight: bold;
	font-size: 24px;
}

.wide-multi-content-container {
	display: flex;
	justify-content: space-between;
	gap: 20px; /* 테이블 간격을 조정합니다. */
}

.buttons-container {
	position: relative;
}

.button {
	background-color: #0074cc;
	color: white;
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.button:hover {
	background-color: #0056a4;
}

#content {
	margin-top: 100px;
}

.cart-container {
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	overflow: hidden;
	width: 80%; /* 변경된 부분: 전체 폭의 80%로 조정 */
	margin: 0 auto;
	padding: 20px;
}

table {
	width: 100%; /* 변경된 부분: 테이블을 100%로 확장 */
	border-collapse: collapse;
	margin-top: 20px;
}

th, td {
	border: 1px solid #ddd;
	padding: 15px; /* 변경된 부분: 셀 내부의 패딩을 조금 늘림 */
	text-align: center;
}

th {
	background-color: #007bff;
	color: #fff;
}
</style>
</head>
<body>
	<!-- Template.jsp -->
	<%@ include file="/WEB-INF/views/inc/header.jsp"%>
	<!-- Header -->

	<main id="main">

		<div id="title">
			<h2>장바구니</h2>
		</div>

		<hr>

		<div class="cart-container">
			<header>
				<h3>장바구니</h3>
			</header>

			<table>
				<thead>
					<tr>
						<th>상품명</th>
						<th>가격</th>
						<th>수량</th>
						<th>합계</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<form name="order-form" action="/ddstudio/member/purchase/view.do"
						method="post">
						<c:forEach items="${list}" var="dto">
							<tr>
								<td>${dto.name}</td>
								<td>${dto.price}</td>
								<td>${dto.ea}</td>
								<td>${dto.total_price}</td>
								<td class="checkbox-col"><input type="checkbox"
									name="reservationCheckbox" value="${dto.user_cart_seq}"></td>
							</tr>
						</c:forEach>
					</form>
				</tbody>
			</table>

			<div class="buttons-container">
				<button class="button" id="order">주문하기</button>
			</div>
		</div>
	</main>
	<%@ include file="/WEB-INF/views/inc/footer.jsp"%>
	<!-- Footer -->

	<script>
	$('#order').click(function() {
		
            var selectedUserBookSeqs = $('input[name="reservationCheckbox"]:checked').map(function() {
                return this.value;
            }).get();

            // 선택된 예매 정보를 서버로 전송
            $.ajax({
                type: 'POST',
                url: '/ddstudio/member/purchase/view.do',
                data: { user_book_seq: selectedUserBookSeqs },
                traditional: true,
                
                dataType: 'json',
                success: function(data) { //data == { "result" : 1 }
                    // 서버에서의 응답에 대한 처리
                    // 예를 들면, 삭제 후에 어떤 동작을 할지에 대한 로직을 추가할 수 있습니다.
                    if (data.result == 1) {
                    	location.href = '/ddstudio/member/purchase/view.do';
                    } else {
                    	alert('failed');
                    }
                },
                error: function() {
                    alert('예매 취소에 실패했습니다.');
                }
            })
	};
        
    
	
	</script>
</body>
</html>


