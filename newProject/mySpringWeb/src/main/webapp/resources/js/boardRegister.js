document.getElementById('trigger').addEventListener('click',()=>{
    document.getElementById('files').click();
})

const regExp = new RegExp("\.(exe|sh|bat|js|msi|dill)$");
const regExpImg = new RegExp("\.(jpg|jpeg|png|gif)$");
const maxSize = 1024*1024*20;

function fileValidation(fileName, fileSize){
    if(!regExpImg.test(fileName)){
        return 0;
    }else if(regExp.test(fileName)){
        return 0;
    }else if(fileSize > maxSize){
        return 0;
    }else{
        return 1;
    }
}

document.addEventListener('change',(e)=>{
    if(e.target.id == 'files'){
        document.getElementById('regBtn').disabled = false;

        // input file element에 저장된 file 정보 property
        const fileObj = document.getElementById('files').files;
        console.log(fileObj);

        // 첨부파일에 대한 정보를 fileZone에 기록
        let div = document.getElementById('fileZone');

        // 기존 값이 있다면 삭제
        div.innerHTML = "";

        let isOk = 1;
        // <ul class="list-group">
        // <li class="list-group-item">An item</li>
        // </ul>
        let ul = `<ul class="list-group">`
        for(let file of fileObj){
            let validResult = fileValidation(file.name, file.size);
            isOk *- validResult;
            ul += `<li class="list-group-item">`;
            ul += `<div class="mb-3">`;
            ul += `${validResult ? '<div class="mb-3">업로드 가능</div>' : '<div class="mb-3">업로드 불가능</div>'} `;
            ul += `${file.name} `;
            ul += `<span class="badge bg-primary rounded-pill">${file.size}</span></div>`;
        }
        ul += `</li></ul>`;
        div.innerHTML = ul;

        if(isOk == 0){
            document.getElementById('regBtn').disabled = true;
        }
    }

})