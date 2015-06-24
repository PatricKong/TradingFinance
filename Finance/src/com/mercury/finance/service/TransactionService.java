package com.mercury.finance.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mercury.common.db.HibernateDao;
import com.mercury.finance.model.Transaction;

@Service
@Transactional
public class TransactionService {
	@Autowired
	@Qualifier("transactionDao")
	private HibernateDao<Transaction, Integer> transD;

	public void saveToFile(String fileName, Transaction transaction){
		try{

			File file =new File(fileName);
    		if(!file.exists()){
    			file.createNewFile();
    			FileWriter fileWritter = new FileWriter(fileName);
    			fileWritter.append("trans_id");
    			fileWritter.append(',');
    			fileWritter.append("tid");
    			fileWritter.append(',');
    			fileWritter.append("qty");
    			fileWritter.append(',');
        		fileWritter.append("status");
        		fileWritter.append(',');
    			fileWritter.append("t_date");
    			fileWritter.append(',');
    			fileWritter.append("process");
    			fileWritter.append(',');
    			fileWritter.append("price");
    			fileWritter.append(',');
    			fileWritter.append("sname");
    			fileWritter.append('\n');
    			fileWritter.flush();
    			fileWritter.close();
    		}
    		FileWriter fileWritter = new FileWriter(fileName,true);
    		BufferedWriter bufferWritter = new BufferedWriter(fileWritter);
    		bufferWritter.write(Integer.toString(transaction.getTrans_id()));
		    bufferWritter.write(',');
		    bufferWritter.write(Integer.toString(transaction.getTrader().getTid()));
		    bufferWritter.write(',');
			bufferWritter.write(Integer.toString(transaction.getQty()));
			bufferWritter.write(',');
			bufferWritter.write(transaction.getStatus());
			bufferWritter.write(',');
			bufferWritter.write(transaction.getT_date());
			bufferWritter.write(',');
			bufferWritter.write(transaction.getProcess());
			bufferWritter.write(',');
			bufferWritter.write(Double.toString(transaction.getPrice()));
			bufferWritter.write(',');
			bufferWritter.write(transaction.getSname());
			bufferWritter.write('\n');
			bufferWritter.flush();
			bufferWritter.close();
			fileWritter.flush();
			fileWritter.close();
		    }catch(IOException e){
		    	e.printStackTrace();
		     }
		}
	public void commitAll(String fileName){
		try {
			BufferedReader br = new BufferedReader(new FileReader(fileName));
			String line = br.readLine();
			while((line = br.readLine()) != null){
	             String[] trans_id = line.split(",");
	             Transaction transaction = transD.findBy("trans_id", Integer.parseInt(trans_id[0]));
	             System.out.println(Integer.parseInt(trans_id[0]));
	             transaction.getPrice();
	             transaction.setProcess("complete");
	             transD.save(transaction);
	        }
	        br.close();
		} catch (IOException e) {
			System.out.println("File did not found");
		} 
		
		try{
    		File file = new File(fileName);
    		if(file.delete()){
    			System.out.println(file.getName() + " is deleted!");
    		}else{
    			System.out.println("Delete operation is failed.");
    		}
    	}catch(Exception e){
    		e.printStackTrace();
    	}
	}
}

	
	
