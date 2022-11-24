function sendit() {
    const userpw = document.getElementById('userpw');
    const userpw_re = document.getElementById('userpw_re');
    const name = document.getElementById('name');
    const hp = document.getElementById('hp');
    const email = document.getElementById('email');
    const hobby = document.getElementsByName('hobby');

    const expPw = /(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[~!#$%^&*])[A-Za-z\d~!@#$%^&*]{8,}/;
    const expName =/[가-힣]+$/;
    const expHp = /^\d{3}-\d{3,4}-\d{4}/;
    const expEmail = /^[A-Za-z0-9\-\.]+@[A-Za-z0-9\-\.]+\.[A-Za-z0-9]+$/;
     

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




