package com.myweb.www.controller;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.myweb.www.domain.CommentVO;
import com.myweb.www.domain.PagingVO;
import com.myweb.www.handler.PagingHandler;
import com.myweb.www.service.CommentService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/comment/*")
public class CommentController {

	@Inject
	private CommentService csv;
	
	@PostMapping(value = "/post", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> post(@RequestBody CommentVO cvo) {
		log.info(">>>> cvo >> "+cvo);
		
		int isOk = csv.post(cvo);
		
		return isOk > 0 ? new ResponseEntity<String>("1", HttpStatus.OK)
				: new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/{bno}/{page}", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<PagingHandler> spread(@PathVariable("bno")long bno,
			@PathVariable("page")int page){
		log.info(">>>>>> bno, page >>> "+bno+" "+page);
		PagingVO pgvo = new PagingVO(page, 5);
		
//		List<CommentVO> list = csv.getList(bno);
		return new ResponseEntity<PagingHandler>(csv.getList(bno,pgvo), HttpStatus.OK);
	}
	
	@DeleteMapping(value = "/{bno}/{cno}", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> remove(@PathVariable("bno")long bno, @PathVariable("cno")long cno){
		log.info(">>>>>> bno, cno >>>> "+bno+", "+cno);
		
		int isOk = csv.remove(bno, cno);
		
		return isOk > 0 ? new ResponseEntity<String>("1",HttpStatus.OK)
				: new ResponseEntity<String>("0",HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PutMapping(value = "/{cno}", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> modify(@RequestBody CommentVO cvo){
		log.info(">>>>> cno, content >> "+cvo.getCno()+" "+cvo.getContent());
		
		int isOk = csv.modify(cvo);

		return isOk > 0 ? new ResponseEntity<String>("1",HttpStatus.OK)
				: new ResponseEntity<String>("0",HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
}
