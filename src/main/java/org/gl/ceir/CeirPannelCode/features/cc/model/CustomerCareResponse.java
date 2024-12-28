package org.gl.ceir.CeirPannelCode.features.cc.model;

import org.gl.ceir.CeirPannelCode.features.notification.model.NotificationModel;

import java.util.List;

public class CustomerCareResponse {
    private List<?> requestIdResponse;
    private List<NotificationModel> notificationEntity;
    public CustomerCareResponse() {

    }

    public List<?> getRequestIdResponse() {
        return requestIdResponse;
    }

    public CustomerCareResponse setRequestIdResponse(List<?> requestIdResponse) {
        this.requestIdResponse = requestIdResponse;
        return this;
    }

    public List<NotificationModel> getNotificationEntity() {
        return notificationEntity;
    }

    public CustomerCareResponse setNotificationEntity(List<NotificationModel> notificationEntity) {
        this.notificationEntity = notificationEntity;
        return this;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("CustomerCareResponse{");
        sb.append("requestIdResponse=").append(requestIdResponse);
        sb.append(", notificationEntity=").append(notificationEntity);
        sb.append('}');
        return sb.toString();
    }
}

