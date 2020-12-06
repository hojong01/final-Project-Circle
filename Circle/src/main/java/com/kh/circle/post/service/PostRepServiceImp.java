package com.kh.circle.post.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.kh.circle.post.entity.Post;
import com.kh.circle.post.entity.PostReply;
import com.kh.circle.post.repository.PostRepDao;

@Service
public class PostRepServiceImp implements PostRepService{

	
	@Autowired
	PostRepDao repDao;
	
//list
	@Override
	public List<Post> replyList(String post_code) {
		return repDao.replyList(post_code);
	}

//insert
	@Override
	public void replyInsert(Post post) {

		repDao.replyInsert(post);
	}

//update
	@Override
	public void replyUpdate(Post post) {

		repDao.replyUpdate(post);
		
	}

//delete
	@Override
	public void replyDelete(Post post) {

		
		repDao.replyDelte(post);
	}

//select
	@Override
	public Post selectReply(String post_repl_code) {

		
		return repDao.replySelect(post_repl_code);
	}


	
}
