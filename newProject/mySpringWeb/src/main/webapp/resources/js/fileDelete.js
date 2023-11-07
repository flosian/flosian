document.addEventListener('click',(e)=>{
    console.log(e.target);
    if(e.target.classList.contains('fileDelBtn')){
        console.log('삭제 버튼 클릭');
        let uuid = e.target.dataset.uuid;
        deleteFileToServer(uuid).then(result => {
            if(result == 1){
                Swal.fire({
                    icon: 'success',
                    text: '삭제되었습니다.'
                })
                e.target.closest('li').remove();
            }else{
                Swal.fire({
                    icon: 'warning',
                    text: '삭제되지 않았습니다.'
                }) 
            }
        })
    }

})

async function deleteFileToServer(uuid){
    try {
        const url = "/board/file/"+uuid;
        const config = {
            method : "delete"
        }
        let resp = await fetch(url,config);
        let result = await resp.text();
        return result;

    } catch (error) {
        console.log(error);
    }
}