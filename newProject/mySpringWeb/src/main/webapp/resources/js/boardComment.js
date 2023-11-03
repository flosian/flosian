// ----- 댓글 작성 -----
document.getElementById('cmtBtn').addEventListener('click',()=>{
    let cmtWriter = document.getElementById('writer').innerText;
    let cmtContent = document.getElementById('comment').value;

    if(cmtContent == "" || cmtContent == null){
        Swal.fire({
            icon: 'warning',
            text: '댓글이 작성되지 않았습니다.'
        })
        return false;
    }else{
        let cmtData = {
            writer : cmtWriter,
            content : cmtContent,
            bno : bnoVal
        }
        postCommentToServer(cmtData).then(result =>{
            console.log(cmtData);
            if(result){
                Swal.fire({
                    icon: 'success',
                    text: '등록되었습니다.'
                })
                document.getElementById('comment').innerText = "";

            }
        })
    }

})

async function postCommentToServer(cmtData){
    try {
        const url = "/comment/post";
        const config = {
            method : "post",
            headers : {
                "content-type" : "application/json; charset=UTF-8"
            },
            body : JSON.stringify(cmtData)
        };

        const resp = await fetch(url, config);
        const result = resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}
// ----- 댓글 작성 end -----
// ----- 댓글 출력 -----
async function getCommentToServer(bno){
    try {
        const url = "/comment/"+bno;
        let resp = await fetch(url);
        let result = resp.json();
        return result;
    } catch (error) {
        console.log(error);
    }
}
function spreadComment(bno){
    let ul = document.getElementById('cmtUl');
    ul.innerHTML = "";
    getCommentToServer(bno).then(result =>{
        console.log(result);
        
        for(let cvo of result){
            let li = ``;
            li += `<li class="list-group-item" data-cno="${cvo.cno}">`;
            li += `<div class="ms-2 me-auto">`;
            li += `<div class="fw-bold">${cvo.writer} `;
            li += `<span class="badge bg-primary rounded-pill">${cvo.regAt}</span></div>`;
            li += `${cvo.content}<br>`;
            li += `<div class="btn-group" role="group" aria-label="Basic outlined example">`;
            li += `<button type="button" class="btn btn-outline-primary mod" data-bs-toggle="modal" data-bs-target="#exampleModal">수정</button>`;
            li += `<button type="button" class="btn btn-outline-primary del">삭제</button>`;
            li += `</div></div></li>`;
            ul.innerHTML += li;
        }

    })
}
// ----- 댓글 출력 end -----
// ----- 댓글 수정 -----
async function editCommentToServer(modData){
    try {
        const url = "/comment/"+modData.cno;
        const config = {
            method : "put",
            headers : {
                "content-type" : "application/json; charset=UTF-8"
            },
            body : JSON.stringify(modData)
        };
        const resp = await fetch(url, config);
        const result = resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}
// ----- 댓글 삭제 -----
async function removeCommentToServer(cno){
    try {
        const url = "/comment/"+cno;
        const config = {
            method : "delete"
        };
        const resp = await fetch(url, config);
        const result = resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}
document.addEventListener('click',(e)=>{
    console.log(e);
    if(e.target.classList.contains('mod')){
        console.log('수정 버튼');

        let li = e.target.closest('li');
        console.log('li cno : '+li.dataset.cno);
        document.getElementById('modBtn').setAttribute('data-cno', li.dataset.cno);

        let comment = li.querySelector('.fw-bold').nextSibling.nodeValue;
        document.getElementById('modCmtInput').value = comment;

    }else if(e.target.id == 'modBtn'){
        let cmtCno = document.getElementById('modBtn').dataset.cno;
        let comment = document.getElementById('modCmtInput').value
        console.log(cmtCno+", "+comment);

        const modData = {
            cno : cmtCno,
            bno : bnoVal,
            content : comment
        }

        editCommentToServer(modData).then(result=>{
            if(result > 0){
                Swal.fire({
                    icon: 'success',
                    text: '댓글이 수정되었습니다.'
                })
                spreadComment(bnoVal);
            }
        })

    }else if(e.target.classList.contains('del')){
        console.log('삭제 버튼');
        let li = e.target.closest('li');
        console.log('li cno : '+li.dataset.cno);

        removeCommentToServer(li.dataset.cno).then(result =>{
            if(result > 0){
                Swal.fire({
                    icon: 'success',
                    text: '댓글이 삭제되었습니다.'
                })
                spreadComment(bnoVal);
            }
        })
    }
    
})
