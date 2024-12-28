package org.gl.ceir.CeirPannelCode.Util;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;





public class HttpClient {

	private Logger logger = (Logger) LogManager.getLogger(HttpClient.class);

	private Map<String, String> headers;
	private List<String> responseHeadersName;

	public Map<String, String> getHeaders() {
		return headers;
	}

	public HttpClient setHeaders(Map<String, String> headers) {
		this.headers = headers;
		return this;
	}

	public List<String> getResponseHeadersName() {
		return responseHeadersName;
	}

	public HttpClient setResponseHeadersName(List<String> responseHeadersName) {
		this.responseHeadersName = responseHeadersName;
		return this;
	}

	public HttpResponse sendGet(String url) throws IOException {
		HttpResponse httpCgResponse = new HttpResponse();
		URL obj = new URL(url);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		con.setRequestMethod("GET");

		if(headers != null) {
			headers.forEach((k, v) -> con.setRequestProperty(k, v));
		}

		int responseCode = con.getResponseCode();

		httpCgResponse.setStatusCode(responseCode);

		if (responseCode/100 == 2) {
			BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
			String inputLine;
			StringBuffer response = new StringBuffer();

			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();

			httpCgResponse.setResponse(response.toString());
		}else{
			BufferedReader in = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			String inputLine;
			StringBuffer response = new StringBuffer();

			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();
			logger.info("http CG Response: "+httpCgResponse);
			httpCgResponse.setResponse(response.toString());
		}

		return httpCgResponse;
	}

	public HttpResponse sendHead(String url) throws IOException {
		HttpResponse httpResponse = new HttpResponse();
		URL obj = new URL(url);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		con.setRequestMethod("HEAD");

		if(headers != null) {
			headers.forEach((k, v) -> con.setRequestProperty(k, v));
		}

		int responseCode = con.getResponseCode();
		httpResponse.setStatusCode(responseCode);
		
		// Set Headers which came back in response.
		if(responseHeadersName.size() > 0) {
			Map<String, String> responseHeaderMap = new HashMap<>();
			
			for(String responseHeader : responseHeadersName) {
				responseHeaderMap.put(responseHeader, con.getHeaderField(responseHeader));
			}
			
		//	httpResponse.setResponse(responseHeaderMap);
		}

		// Check response.
		if (responseCode/100 == 2) {

			BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
			String inputLine;
			StringBuffer response = new StringBuffer();

			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();

			httpResponse.setResponse(response.toString());
		}else{
			
			BufferedReader in = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			String inputLine;
			StringBuffer response = new StringBuffer();

			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();
			logger.info("http CG Response: " + httpResponse);
			httpResponse.setResponse(response.toString());
		}

		return httpResponse;
	}

	public HttpResponse sendPost(String url, String body) throws IOException {
		HttpResponse httpCustomResponse = new HttpResponse();
		URL obj = new URL(url);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		con.setRequestMethod("POST");
		con.setRequestProperty("Accept", "application/json");
		con.setRequestProperty("Content-type", "application/json");

		if(headers != null) {
			headers.forEach((k, v) -> con.setRequestProperty(k, v));
		}

		// For POST only - START
		con.setDoOutput(true);
		OutputStream os = con.getOutputStream();
		os.write(body.getBytes());
		os.flush();
		os.close();
		// For POST only - END

		int responseCode = con.getResponseCode();
		System.out.println("POST Response Code :: " + responseCode);
		httpCustomResponse.setStatusCode(responseCode);
		if (responseCode == 200) { //success

			BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
			String inputLine;
			StringBuffer response = new StringBuffer();

			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();
			httpCustomResponse.setResponse(response.toString());
			// print result
		} else {
			BufferedReader in = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			String inputLine;
			StringBuffer response = new StringBuffer();

			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();
			httpCustomResponse.setResponse(response.toString());
			// print result
		}

		return httpCustomResponse;
	}


	public String sendDelete(String url, String body) throws IOException {
		URL obj = new URL(url);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		con.setRequestMethod("DELETE");
		con.setRequestProperty("Accept", "application/json");
		con.setRequestProperty("Content-type", "application/json");

		if(headers != null) {
			headers.forEach((k, v) -> con.setRequestProperty(k, v));
		}

		int responseCode = con.getResponseCode();
		System.out.println("DELETE Response Code :: " + responseCode);

		if (responseCode == HttpURLConnection.HTTP_OK) { //success

			BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
			String inputLine;
			StringBuffer response = new StringBuffer();

			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();

			// print result
			return response.toString();
		} else {
			System.out.println("DELETE request not worked");
		}

		return null;
	}

	public String sendPut(String url, String body) throws IOException {
		URL obj = new URL(url);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		con.setRequestMethod("PUT");
		con.setRequestProperty("Accept", "application/json");
		con.setRequestProperty("Content-type", "application/json");

		if(headers != null) {
			headers.forEach((k, v) -> con.setRequestProperty(k, v));
		}

		con.setDoOutput(true);

		OutputStreamWriter osw = new OutputStreamWriter(con.getOutputStream());
		osw.write(body);
		osw.flush();
		osw.close();

		int responseCode = con.getResponseCode();

		if (responseCode == HttpURLConnection.HTTP_OK) { //success

			BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
			String inputLine;
			StringBuffer response = new StringBuffer();

			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();

			// print result
			return response.toString();
		} else {
			System.out.println("Request not worked");
		}

		return null;
	}

	public static void main() {
		HttpClient httpClient = new HttpClient();
		try {
			System.out.println(httpClient.sendHead("http://th.gw2cloud.com/api/aoc.php"));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}