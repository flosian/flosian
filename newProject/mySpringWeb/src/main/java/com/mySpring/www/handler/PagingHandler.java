package com.mySpring.www.handler;

import com.mySpring.www.domain.PagingVO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PagingHandler {

	private int startPage;
	private int endPage;
	private int realEndPage;
	private boolean prev, next;
	
	private int totalCount;
	private PagingVO pgvo;
	
	public PagingHandler(PagingVO pgvo, int totalCount) {
		this.pgvo = pgvo;
		this.totalCount = totalCount;
		
		this.endPage =
				(int) (Math.ceil(pgvo.getPageNo() / (double)pgvo.getQty()) * pgvo.getQty());
													// 한 페이지의 게시글 수		// 페이징 개수
		
		this.startPage = endPage - 9;
		
		this.realEndPage =
				(int) Math.ceil(totalCount/ (double)pgvo.getQty());
											// 한 페이지의 게시글 수
		
		if(realEndPage < endPage) {
			this.endPage = realEndPage;
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < this.realEndPage;
		
	}
	
	
}
