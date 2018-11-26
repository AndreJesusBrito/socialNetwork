package buffertest;
import java.io.*;
import java.util.*;
public class usergen {

	public static void main(String[]args) throws IOException {
 		
 		//create PSQL INSERT USER
 		makeUser(2000);
 		
	}
	public static void makeUser(int n) throws IOException {
		List<String> fname;
		List<String> lname;
 		List<String> country;
 		List<String> city;
 		List<String> bio;
 		List<String> avatar;
 		BufferedReader xd = new BufferedReader(new FileReader("C:\\Users\\Bruno\\eclipse-workspace\\sqlGen\\src\\buffertest\\lorem.txt"));
		bio = readFile(xd);
		xd.close();
		
		BufferedReader avatarR = new BufferedReader(new FileReader("C:\\Users\\Bruno\\eclipse-workspace\\sqlGen\\src\\buffertest\\avatar.txt"));
		avatar = readFile(avatarR);
		avatarR.close();
		
		BufferedReader fn = new BufferedReader(new FileReader("C:\\Users\\Bruno\\eclipse-workspace\\sqlGen\\src\\buffertest\\firstname.txt"));
		fname = readFile(fn);
		fn.close();
	
		BufferedReader ln = new BufferedReader(new FileReader("C:\\Users\\Bruno\\eclipse-workspace\\sqlGen\\src\\buffertest\\lastname.txt"));
		lname = readFile(ln);
		ln.close();
		BufferedReader ct = new BufferedReader(new FileReader("C:\\Users\\Bruno\\eclipse-workspace\\sqlGen\\src\\buffertest\\country.txt"));
		country = readFile(ct);
		ct.close();
		BufferedReader citi = new BufferedReader(new FileReader("C:\\Users\\Bruno\\eclipse-workspace\\sqlGen\\src\\buffertest\\citiesout.txt"));
		city = readFile(citi);
		ct.close();
		
		Random rn = new Random();
		List <String> name = new ArrayList <String>();
		String l;
		for(int i = 0; i < n; i++) {
			l = new String(fname.get(rn.nextInt(fname.size()-1))+" "+lname.get(rn.nextInt(lname.size()-1)));
			name.add(l);
		}
		String[]s;
		
 		//int i = 0;
		BufferedWriter bw = new BufferedWriter(new FileWriter("C:\\Users\\Bruno\\eclipse-workspace\\sqlGen\\src\\buffertest\\users.sql"));
		List <String> email = new ArrayList();
		Collections.addAll(email,"@hotmail.com","@gmail.com","@ualg.pt","@outlook.com","@office.com");
		int rd;
		for(int i =0 ; i < name.size();i++)  {
			bw.write("insert into users values(");
			bw.newLine();
			bw.write("\t'"+i+"',");
			bw.newLine();
			bw.write("\t'"+name.get(i)+"',");
			bw.newLine();
			rd = rn.nextInt(country.size()-1);
			bw.write("\t'"+city.get(rd)+"',");
			bw.newLine();
			bw.write("\t'"+country.get(rd)+"',");
			bw.newLine();
			s = name.get(i).split(" ");
			rd = rn.nextInt(email.size()-1);
			bw.write("\t'"+s[0]+s[1]+email.get(rd)+ "',");
			bw.newLine();
			bw.write("\t'"+fakepw()+"',");
			bw.newLine();
			bw.write("\t'"+(rn.nextInt(28)+1)+"/"+(rn.nextInt(11)+1)+"/"+(rn.nextInt(2018-1920)+1920)+"',");
			rd = rn.nextInt(bio.size()-1);
			bw.newLine();
			rd = rn.nextInt(avatar.size()-1);
			bw.write("\t'"+avatar.get(rd)+"',");
			bw.newLine();
			bw.write("\t'"+bio.get(rd)+"');");
			bw.newLine();
			bw.newLine();
		}
		bw.close();
		
	}
	public static String fakepw() {
		String s="";
		char c;
		Random rn = new Random();
		for(int i = 0; i < 8;i++) {
			c = (char)(rn.nextInt(26) + 'a');
			s+=c;
		}
		return s;
	}
	public static List<String> readFile(BufferedReader br)throws IOException {
		List <String> f = new ArrayList<String>();
		String l = null;
		while((l = br.readLine())!=null) {
			if(l.length() > 2)
			f.add(l);
		}
		return f;
	}

}
