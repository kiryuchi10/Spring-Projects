        document.addEventListener("DOMContentLoaded", function() {
            const urlParams = new URLSearchParams(window.location.search);
            const errorParam = urlParams.get('error');
            if (errorParam) {
                if (errorParam === 'unauthorized') {
                    alert('로그인이 필요합니다.');
                } else {
                    alert('아이디 또는 비밀번호가 잘못되었습니다.');
                }
            }
        });

        function validateLoginForm(event) {
            var username = document.getElementById('username').value;
            var password = document.getElementById('password').value;

            if (username === '' || password === '') {
                alert('아이디와 패스워드를 모두 입력해주세요.');
                return false; // 폼 제출을 막음
            }

            // 추가적인 클라이언트 측 유효성 검사를 여기서 수행할 수 있음

            return true; // 폼 제출을 허용
        }

function checkName(event) {
	console.log("작동 함!");
	//	이벤트 발생 객체 
	const obj = event.target;	//	button#check-email
	const target = obj.getAttribute("data-target");	//	API 호출 위치
	const frm = obj.form;	//	폼 
	
	const name = frm.name.value.trim();
	
	if (name.length === 0) {
		alert("이름을 입력하세요!");
		return;
	}
	
	//	fetch
	console.log(`${target}?name=${name}`);
	fetch(`${target}?name=${name}`)
	.then(response => {
		console.log(response);
		return response.json();
	})
	.then(json => {
		console.log(json);
		//	중복 여부
		if (json.exists) {
			alert('이미 사용중인 아이디입니다.')
			throw new Error('중복된 아이디입니다.');
		} else {
			alert('사용 가능한 아이디입니다.');
			frm.checkedName.value = "y";
		}
	})
	.catch(error => console.error(error));
}


window.addEventListener("load", event => {
	document.getElementById("checkName")
		.addEventListener("click", checkName);
		
	// 가입 폼 Validation
	
	document.getElementById("joinForm")
		.addEventListener("submit", event => {
		const frm = event.target;
		
		event.preventDefault();
		
		//	이름 검증
		if (frm.name.value.trim().length === 0) {
			alert("이름을 입력하세요");
			frm.name.focus();
			return;
		}
		//	비밀번호 검증
		if (frm.password.value.trim().length === 0) {
			alert("비밀번호를 입력하세요");
			frm.password.focus();
			return;
		}
		//	이메일 검증
		if (frm.branchId.value.trim().length === 0) {
			frm.email.focus();
			return;
		}

		//	이메일 중복체크 여부 판단
		if (frm.checkedName.value !== "y") {
			alert("이름 중복 여부를 확인을 해주세요");
			return;
		}

		
		//	전송
		frm.submit();
		
	});
	
});