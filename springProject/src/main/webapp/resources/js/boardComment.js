console.log(bnoVal);
async function postCommentToServer(cmtData){
    try {
        const url = "/comment/post";
        const config = {
            method : "post",
            headers : {
                'content-type' : 'application/json; charset=UTF-8'
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

document.getElementById('cmtPostBtn').addEventListener('click', () => {
    const cmtTxt = document.getElementById('cmtTxt').value;
    const cmtWriter = document.getElementById('cmtWriter').innerText;
    if(cmtTxt == "" || cmtTxt == null){
        alert('댓글을 입력해주세요');
        document.getElementById('cmtTxt').focus();
        return false;
    }else{
        let cmtData = {
            bno : bnoVal,
            writer : cmtWriter,
            content : cmtTxt
        };
        console.log(cmtData);
        postCommentToServer(cmtData).then(result => {
            console.log(result);
            if(result == 1){
                alert('댓글 등록 성공');
                document.getElementById('cmtTxt').value = '';
                getCommentList(bnoVal);
            }
        })
    }
})

async function spreadCommentListFromServer(bno, page){
    try {
        const resp = await fetch('/comment/'+bno+'/'+page);
        const result = await resp.json();
        return result;

    } catch (error) {
        console.log(error);
    }
}

// 무조건 처음 뿌릴 때는 첫 페이지 값을 뿌려야 함
function getCommentList(bno, page=1){
    spreadCommentListFromServer(bno, page).then(result => {
        console.log(result); // ph 객체 pgvo, totalCount, cmtList
        if(result.cmtList.length > 0){
            let cmtListArea = document.getElementById('cmtListArea');
            // 다시 댓글을 뿌릴 때 기존 값 삭제 *1page일 경우만
            if(page==1){
                cmtListArea.innerHTML = "";
            }

            for(let cvo of result.cmtList){
                let li = `<li class="list-group-item" data-cno="${cvo.cno}" data-writer="${cvo.writer}"><div class="mb-3">`;
                li += `<div class="fw-bold">${cvo.writer}</div>${cvo.content}`;
                li += `<span class="badge rounded-pill text-bg-dark">${cvo.modAt}</span><br>`;
                li += `<button type="button" class="btn btn-dark modBtn" data-bs-toggle="modal" data-bs-target="#myModal">%</button>`;
				li += `<button type="button" class="btn btn-outline-danger delBtn">X</button>`;
                li += `</div></li>`;
                cmtListArea.innerHTML += li;
            }

            // 댓글 페이징 코드
            let moreBtn = document.getElementById('moreBtn');
            // db에서 pgvo + list 를 같이 가져와야 값을 줄 수 있음
            if(result.pgvo.pageNo < result.endPage || result.next){
                moreBtn.style.visibility = 'visible';
                moreBtn.dataset.page = page + 1;
            }else {
                moreBtn.style.visibility = 'hidden';
            }

        }else{
            let li = `<li>Comment List Empty</li>`;
            cmtListArea.innerHTML = li;
        }
    })
}

async function removeCommentToServer(cno,bno){
    try {
        const url = '/comment/'+bno+'/'+cno;
        const config = {
            method : 'delete'
        }

        const resp = await fetch(url, config);
        const result = resp.text();
        return result;

    } catch (error) {
        console.log(error);
    }
}

async function editCommentToServer(cmtDataMod){
    try {
        const url = '/comment/'+cmtDataMod.cno;
        const config = {
            method : 'put',
            headers : {
                'Content-Type' : 'application/json; charset=UTF-8'
            },
            body : JSON.stringify(cmtDataMod)
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}

document.addEventListener('click', (e)=>{
    console.log(e.target);
    if(e.target.classList.contains('delBtn')){
        console.log('취소 버튼 클릭~');

        let li = e.target.closest('li');
        let cnoVal = li.dataset.cno;
        console.log(cnoVal);

        removeCommentToServer(cnoVal, bnoVal).then(result => {
            if(result == 1){
                alert('댓글 삭제 성공');
            }
            getCommentList(bnoVal);
        })

    }else if(e.target.classList.contains('modBtn')){
        let li = e.target.closest('li');
        // nextSibling() : 같은 부모의 다음 형제 객체를 반환
        let cmtTxt = li.querySelector('.fw-bold').nextSibling;

        // 기존 내용 모달창에 반영 (수정 용이하게)
        document.getElementById('cmtTxtMod').value = cmtTxt.nodeValue;
        // cmtModBtn에 data-cno 달기
        document.getElementById('cmtModBtn').setAttribute('data-cno', li.dataset.cno);

    }else if(e.target.id == 'cmtModBtn'){
        let cmtDataMod = {
            cno : e.target.dataset.cno,
            content : document.getElementById('cmtTxtMod').value
        };
        console.log(cmtDataMod);
        editCommentToServer(cmtDataMod).then(result => {
            if(parseInt(result)){
                // 모달창 닫기
                document.querySelector('.btn-close').click();
            }
            getCommentList(bnoVal);
        })
    }else if(e.target.id == 'moreBtn'){
        getCommentList(bnoVal, parseInt(e.target.dataset.page));
        
    }

})