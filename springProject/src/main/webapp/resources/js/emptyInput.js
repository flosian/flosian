console.log(checkEmpty);


async function checkEmptyInput(){
    if(document.getElementsByName('title')[0].value == ""){
        document.getElementById('checkTitle').innerText='제목을 입력해주세요';

    }
}