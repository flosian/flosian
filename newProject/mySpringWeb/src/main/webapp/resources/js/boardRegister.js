document.getElementById('trigger').addEventListener('click',()=>{
    document.getElementById('file').click();
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

