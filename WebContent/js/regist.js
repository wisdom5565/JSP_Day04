function sendit() {
    const userid = document.getElementById('userid');
    const userpw = document.getElementById('userpw');
    const userpw_re = document.getElementById('userpw_re');
    const name = document.getElementById('name');
    const hp = document.getElementById('hp');
    const email = document.getElementById('email');
    const hobby = document.getElementsByName('hobby');
    const isIdCheck = document.getElementById('isIdCheck');

    const expId = /^[A-Za-z]{4,20}$/;
    const expPw = /(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[~!#$%^&*])[A-Za-z\d~!@#$%^&*]{8,}/;
    const expName =/[가-힣]+$/;
    const expHp = /^\d{3}-\d{3,4}-\d{4}/;
    const expEmail = /^[A-Za-z0-9\-\.]+@[A-Za-z0-9\-\.]+\.[A-Za-z0-9]+$/;
    
    if(userid.value == '') {
        alert('아이디를 입력하세요!')
        userid.focus();
        return false;
    }
    
    if(!expId.test(userid.value)) {
        alert('아이디는 4자 이상 20자 이하의 대소문자로 시작하는 조합입니다!')
        userid.focus();
        return false;
    }
    
    if(isIdCheck.value == 'n') {
    	alert('아이디 중복체크를 해주세요!')
    	isIdCheck.focus();
    	return false;
    }

    

    if(userpw.value == '') {
        alert('비밀번호를 입력하세요!')
        userpw.focus();
        return false;
    }
    
    if(!expPw.test(userpw.value)) {
        alert('비밀번호는 대문자, 소문자, 특수문자를 포함한 8자 이상이어야 합니다!');
        userpw.focus();
        return false;
    }

    if(userpw_re.value == '') {
        alert('비밀번호 확인을 입력하세요!')
        userpw_re.focus();
        return false;
    }
    
    if(userpw.value != userpw_re.value) {
        alert('비밀번호를 다시 확인해주세요!')
        userpw_re.focus();
        return false;
    }

    if(name.value == '') {
        alert('이름을 입력하세요!')
        name.focus();
        return false;
    }

    if(!expName.test(name.value)){
        alert('이름은 한글 입력만 가능합니다!');
        name.focus();
        return false;
    } 
    


    if(!expHp.test(hp.value)) {
        alert('-포함 숫자만 입력하세요!')
        hp.focus();
        return false;
    }



    if(!expEmail.test(email.value)) {
        alert('이메일 형식을 확인해주세요!')
        email.focus();
        return false;
    }

    let count = 0;
    for(let i in hobby) {
        if(hobby[i].checked){
            count++;
        }
    }

    if(count == 0) {
        alert('취미는 적어도 한 개 이상 선택하세요!')
        return false;
    }


    return true;
}


function clickBtn() {
	const xhr = new XMLHttpRequest();
	const userid = document.getElementById('userid').value;
	const isIdCheck = document.getElementById('isIdCheck');
	xhr.open('get','idCheck.jsp?userid='+userid,true);
	xhr.send();
	xhr.onreadystatechange = function() {
		if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200) {
			const result = xhr.responseText;
			if(result.trim() == "ok") {
				document.getElementById("checkmsg").innerHTML = "<b style='color:deepskyblue;'>사용할 수 있는 아이디입니다!</b>"
				isIdCheck.value = 'y';	
			} else {
				document.getElementById("checkmsg").innerHTML = "<b style='color:red;'>사용할 수 없는 아이디입니다!</b>"
				
			}
		}
	}
}

function idModify() {
	const isIdCheck = document.getElementById('isIdCheck');
	isIdCheck.value ='n';
}