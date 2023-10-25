document.addEventListener('click', (e)=>{
    console.log(e.target);
    if(e.target.classList.contains('fileDelBtn')){
        console.log('삭제 버튼 클릭');
        let uuid = e.target.dataset.uuid;
        deleteFileToServer(uuid).then(result => {
            if(result == 1){
                alert("삭제성공");
                e.target.closest('li').remove();
            }else{
                alert("실패");
            }
        })
    }
})

async function deleteFileToServer(uuid){
    try {
        url = '/board/file/'+uuid;
        config = {
            method : 'delete'
        };

        let resp = await fetch(url, config);
        let result = await resp.text();
        return result;
        
    } catch (error) {
        console.log(error);
    }
}
