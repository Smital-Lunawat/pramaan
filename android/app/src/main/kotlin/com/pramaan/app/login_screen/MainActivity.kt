package com.pramaan.app.login_screen

import io.flutter.embedding.android.FlutterActivity
import com.fasterxml.jackson.dataformat.xml.XmlMapper;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlRootElement;

class MainActivity: FlutterActivity() {
    private fun launchStatelessMatch() {
        val statelessMatchRequest = StatelessMatchRequest()
        statelessMatchRequest.requestId = edtTransactionId.text.toString()
        statelessMatchRequest.signedDocument = lastReadEKYCDocument
        statelessMatchRequest.language = Utils.LANGUAGE
        statelessMatchRequest.enableAutoCapture = Utils.ENABLE_AUTO_CAPTURE.toString()
        val intent = Intent(ACTION).apply {
            putExtra(REQUEST, statelessMatchRequest.toXml())
        }
}

@JacksonXmlRootElement(localName = "statelessMatchRequest")
public class StatelessMatchRequest {
    @JacksonXmlProperty(isAttribute = true)
    public String requestId;

    @JacksonXmlProperty(isAttribute = true)
    public String signedDocument;

    @JacksonXmlProperty(isAttribute = true)
    public String language;

    @JacksonXmlProperty(isAttribute = true)
    public String enableAutoCapture;

    public String toXml() throws Exception {
        return new XmlMapper().writeValueAsString(this);
    }
}