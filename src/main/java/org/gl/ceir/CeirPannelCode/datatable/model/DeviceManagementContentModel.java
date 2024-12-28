package org.gl.ceir.CeirPannelCode.datatable.model;

import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class DeviceManagementContentModel {
		
	private Integer id;
	private String createdOn;
	private String modifiedOn;
	private String deviceId;
	private String marketingName;
	private String manufacturer;
	private Object manufacturingLocation;
	private String modelName;
	private String brandName;
	private String oem;
	private String organizationId;
	private String deviceType;
	private Object allocationDate;
	private Integer imeiQuantity;
	private Integer simSlot;
	private Object esimSupport;
	private Object softsimSupport;
	private Object simType;
	private String os;
	private Object osBaseVersion;
	private Object announceDate;
	private Object launchDate;
	private Object deviceStatus;
	private Object discontinueDate;
	private Object networkTechnologyGSM;
	private Object networkTechnologyCDMA;
	private Object networkTechnologyEVDO;
	private Object networkTechnologyLTE;
	private Object networkTechnology5G;
	private Object networkTechnology6G;
	private Object networkTechnology7G;
	private Object network2GBand;
	private Object network3GBand;
	private Object network4GBand;
	private Object network5GBand;
	private Object network6GBand;
	private Object network7GBand;
	private Object networkSpeed;
	private Object bodyDimension;
	private Object bodyWeight;
	private Object displayType;
	private Object displaySize;
	private Object displayResolution;
	private Object displayProtection;
	private Object platformChipset;
	private Object platformCPU;
	private Object platformGPU;
	private Object memoryCardSlot;
	private Object memoryInternal;
	private Object ram;
	private Object mainCameraType;
	private Object mainCameraSpec;
	private Object mainCameraFeature;
	private Object mainCameraVideo;
	private Object selfieCameraType;
	private Object selfieCameraSpec;
	private Object selfieCameraFeature;
	private Object selfieCameraVideo;
	private Object soundLoudspeaker;
	private Object sound35mmJack;
	private Object commsWLAN;
	private Object commsBluetooth;
	private Object commsGPS;
	private Object commsNFC;
	private Object commsRadio;
	private Object commsUSB;
	private Object sensor;
	private Object batteryType;
	private Object batteryCapacity;
	private Object batteryCharging;
	private Object colors;
	private String removableUICC;
	private String removableEUICC;
	private Object bandDetail;
	private Object launchPriceAsianMarket;
	private Object launchPriceUSMarket;
	private Object launchPriceEuropeMarket;
	private Object launchPriceInternationalMarket;
	private Object launchPriceCambodiaMarket;
	private Object customPriceOfDevice;
	private Object sourceOfCambodiaMarketPrice;
	private Object reportedGlobalIssue;
	private Object reportedLocalIssue;
	private Integer deviceState;
	private Integer userId;
	//private String userType;
	private Integer userType;
	private Object remark;
	private Integer featureId;
	private String userDisplayName;
	private Object publicIp;
	private Object browser;
	private String stateInterp;
	private Object esimSupportInterp;
	private Object softsimSupportInterp;
	private Object networkTechnologyGSMInterp;
	private Object networkTechnologyCDMAInterp;
	private Object networkTechnologyEVDOInterp;
	private Object networkTechnologyLTEInterp;
	private Object networkTechnology5GInterp;
	private Object networkTechnology6GInterp;
	private Object networkTechnology7GInterp;
	private Object memoryCardSlotInterp;
	private Object mainCameraTypeInterp;
	private Object selfieCameraTypeInterp;
	private Object soundLoudspeakerInterp;
	private Object sound35mmJackInterp;
	private Object commsNFCInterp;
	private Object commsRadioInterp;
	private List<Object> attachedFiles;
	private List<String> updateColumns;
	private Integer networkSpecificIdentifier;
	
	public Integer getNetworkSpecificIdentifier() {
		return networkSpecificIdentifier;
	}
	public void setNetworkSpecificIdentifier(Integer networkSpecificIdentifier) {
		this.networkSpecificIdentifier = networkSpecificIdentifier;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getCreatedOn() {
		return createdOn;
	}
	public void setCreatedOn(String createdOn) {
		this.createdOn = createdOn;
	}
	public String getModifiedOn() {
		return modifiedOn;
	}
	public void setModifiedOn(String modifiedOn) {
		this.modifiedOn = modifiedOn;
	}
	public String getDeviceId() {
		return deviceId;
	}
	public void setDeviceId(String deviceId) {
		this.deviceId = deviceId;
	}
	public String getMarketingName() {
		return marketingName;
	}
	public void setMarketingName(String marketingName) {
		this.marketingName = marketingName;
	}
	public String getManufacturer() {
		return manufacturer;
	}
	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}
	public Object getManufacturingLocation() {
		return manufacturingLocation;
	}
	public void setManufacturingLocation(Object manufacturingLocation) {
		this.manufacturingLocation = manufacturingLocation;
	}
	public String getModelName() {
		return modelName;
	}
	public void setModelName(String modelName) {
		this.modelName = modelName;
	}
	public String getBrandName() {
		return brandName;
	}
	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}
	public String getOem() {
		return oem;
	}
	public void setOem(String oem) {
		this.oem = oem;
	}
	public String getOrganizationId() {
		return organizationId;
	}
	public void setOrganizationId(String organizationId) {
		this.organizationId = organizationId;
	}
	public String getDeviceType() {
		return deviceType;
	}
	public void setDeviceType(String deviceType) {
		this.deviceType = deviceType;
	}
	public Object getAllocationDate() {
		return allocationDate;
	}
	public void setAllocationDate(Object allocationDate) {
		this.allocationDate = allocationDate;
	}
	public Integer getImeiQuantity() {
		return imeiQuantity;
	}
	public void setImeiQuantity(Integer imeiQuantity) {
		this.imeiQuantity = imeiQuantity;
	}
	public Integer getSimSlot() {
		return simSlot;
	}
	public void setSimSlot(Integer simSlot) {
		this.simSlot = simSlot;
	}
	public Object getEsimSupport() {
		return esimSupport;
	}
	public void setEsimSupport(Object esimSupport) {
		this.esimSupport = esimSupport;
	}
	public Object getSoftsimSupport() {
		return softsimSupport;
	}
	public void setSoftsimSupport(Object softsimSupport) {
		this.softsimSupport = softsimSupport;
	}
	public Object getSimType() {
		return simType;
	}
	public void setSimType(Object simType) {
		this.simType = simType;
	}
	public String getOs() {
		return os;
	}
	public void setOs(String os) {
		this.os = os;
	}
	public Object getOsBaseVersion() {
		return osBaseVersion;
	}
	public void setOsBaseVersion(Object osBaseVersion) {
		this.osBaseVersion = osBaseVersion;
	}
	public Object getAnnounceDate() {
		return announceDate;
	}
	public void setAnnounceDate(Object announceDate) {
		this.announceDate = announceDate;
	}
	public Object getLaunchDate() {
		return launchDate;
	}
	public void setLaunchDate(Object launchDate) {
		this.launchDate = launchDate;
	}
	public Object getDeviceStatus() {
		return deviceStatus;
	}
	public void setDeviceStatus(Object deviceStatus) {
		this.deviceStatus = deviceStatus;
	}
	public Object getDiscontinueDate() {
		return discontinueDate;
	}
	public void setDiscontinueDate(Object discontinueDate) {
		this.discontinueDate = discontinueDate;
	}
	public Object getNetworkTechnologyGSM() {
		return networkTechnologyGSM;
	}
	public void setNetworkTechnologyGSM(Object networkTechnologyGSM) {
		this.networkTechnologyGSM = networkTechnologyGSM;
	}
	public Object getNetworkTechnologyCDMA() {
		return networkTechnologyCDMA;
	}
	public void setNetworkTechnologyCDMA(Object networkTechnologyCDMA) {
		this.networkTechnologyCDMA = networkTechnologyCDMA;
	}
	public Object getNetworkTechnologyEVDO() {
		return networkTechnologyEVDO;
	}
	public void setNetworkTechnologyEVDO(Object networkTechnologyEVDO) {
		this.networkTechnologyEVDO = networkTechnologyEVDO;
	}
	public Object getNetworkTechnologyLTE() {
		return networkTechnologyLTE;
	}
	public void setNetworkTechnologyLTE(Object networkTechnologyLTE) {
		this.networkTechnologyLTE = networkTechnologyLTE;
	}
	public Object getNetworkTechnology5G() {
		return networkTechnology5G;
	}
	public void setNetworkTechnology5G(Object networkTechnology5G) {
		this.networkTechnology5G = networkTechnology5G;
	}
	public Object getNetworkTechnology6G() {
		return networkTechnology6G;
	}
	public void setNetworkTechnology6G(Object networkTechnology6G) {
		this.networkTechnology6G = networkTechnology6G;
	}
	public Object getNetworkTechnology7G() {
		return networkTechnology7G;
	}
	public void setNetworkTechnology7G(Object networkTechnology7G) {
		this.networkTechnology7G = networkTechnology7G;
	}
	public Object getNetwork2GBand() {
		return network2GBand;
	}
	public void setNetwork2GBand(Object network2gBand) {
		network2GBand = network2gBand;
	}
	public Object getNetwork3GBand() {
		return network3GBand;
	}
	public void setNetwork3GBand(Object network3gBand) {
		network3GBand = network3gBand;
	}
	public Object getNetwork4GBand() {
		return network4GBand;
	}
	public void setNetwork4GBand(Object network4gBand) {
		network4GBand = network4gBand;
	}
	public Object getNetwork5GBand() {
		return network5GBand;
	}
	public void setNetwork5GBand(Object network5gBand) {
		network5GBand = network5gBand;
	}
	public Object getNetwork6GBand() {
		return network6GBand;
	}
	public void setNetwork6GBand(Object network6gBand) {
		network6GBand = network6gBand;
	}
	public Object getNetwork7GBand() {
		return network7GBand;
	}
	public void setNetwork7GBand(Object network7gBand) {
		network7GBand = network7gBand;
	}
	public Object getNetworkSpeed() {
		return networkSpeed;
	}
	public void setNetworkSpeed(Object networkSpeed) {
		this.networkSpeed = networkSpeed;
	}
	public Object getBodyDimension() {
		return bodyDimension;
	}
	public void setBodyDimension(Object bodyDimension) {
		this.bodyDimension = bodyDimension;
	}
	public Object getBodyWeight() {
		return bodyWeight;
	}
	public void setBodyWeight(Object bodyWeight) {
		this.bodyWeight = bodyWeight;
	}
	public Object getDisplayType() {
		return displayType;
	}
	public void setDisplayType(Object displayType) {
		this.displayType = displayType;
	}
	public Object getDisplaySize() {
		return displaySize;
	}
	public void setDisplaySize(Object displaySize) {
		this.displaySize = displaySize;
	}
	public Object getDisplayResolution() {
		return displayResolution;
	}
	public void setDisplayResolution(Object displayResolution) {
		this.displayResolution = displayResolution;
	}
	public Object getDisplayProtection() {
		return displayProtection;
	}
	public void setDisplayProtection(Object displayProtection) {
		this.displayProtection = displayProtection;
	}
	public Object getPlatformChipset() {
		return platformChipset;
	}
	public void setPlatformChipset(Object platformChipset) {
		this.platformChipset = platformChipset;
	}
	public Object getPlatformCPU() {
		return platformCPU;
	}
	public void setPlatformCPU(Object platformCPU) {
		this.platformCPU = platformCPU;
	}
	public Object getPlatformGPU() {
		return platformGPU;
	}
	public void setPlatformGPU(Object platformGPU) {
		this.platformGPU = platformGPU;
	}
	public Object getMemoryCardSlot() {
		return memoryCardSlot;
	}
	public void setMemoryCardSlot(Object memoryCardSlot) {
		this.memoryCardSlot = memoryCardSlot;
	}
	public Object getMemoryInternal() {
		return memoryInternal;
	}
	public void setMemoryInternal(Object memoryInternal) {
		this.memoryInternal = memoryInternal;
	}
	public Object getRam() {
		return ram;
	}
	public void setRam(Object ram) {
		this.ram = ram;
	}
	public Object getMainCameraType() {
		return mainCameraType;
	}
	public void setMainCameraType(Object mainCameraType) {
		this.mainCameraType = mainCameraType;
	}
	public Object getMainCameraSpec() {
		return mainCameraSpec;
	}
	public void setMainCameraSpec(Object mainCameraSpec) {
		this.mainCameraSpec = mainCameraSpec;
	}
	public Object getMainCameraFeature() {
		return mainCameraFeature;
	}
	public void setMainCameraFeature(Object mainCameraFeature) {
		this.mainCameraFeature = mainCameraFeature;
	}
	public Object getMainCameraVideo() {
		return mainCameraVideo;
	}
	public void setMainCameraVideo(Object mainCameraVideo) {
		this.mainCameraVideo = mainCameraVideo;
	}
	public Object getSelfieCameraType() {
		return selfieCameraType;
	}
	public void setSelfieCameraType(Object selfieCameraType) {
		this.selfieCameraType = selfieCameraType;
	}
	public Object getSelfieCameraSpec() {
		return selfieCameraSpec;
	}
	public void setSelfieCameraSpec(Object selfieCameraSpec) {
		this.selfieCameraSpec = selfieCameraSpec;
	}
	public Object getSelfieCameraFeature() {
		return selfieCameraFeature;
	}
	public void setSelfieCameraFeature(Object selfieCameraFeature) {
		this.selfieCameraFeature = selfieCameraFeature;
	}
	public Object getSelfieCameraVideo() {
		return selfieCameraVideo;
	}
	public void setSelfieCameraVideo(Object selfieCameraVideo) {
		this.selfieCameraVideo = selfieCameraVideo;
	}
	public Object getSoundLoudspeaker() {
		return soundLoudspeaker;
	}
	public void setSoundLoudspeaker(Object soundLoudspeaker) {
		this.soundLoudspeaker = soundLoudspeaker;
	}
	public Object getSound35mmJack() {
		return sound35mmJack;
	}
	public void setSound35mmJack(Object sound35mmJack) {
		this.sound35mmJack = sound35mmJack;
	}
	public Object getCommsWLAN() {
		return commsWLAN;
	}
	public void setCommsWLAN(Object commsWLAN) {
		this.commsWLAN = commsWLAN;
	}
	public Object getCommsBluetooth() {
		return commsBluetooth;
	}
	public void setCommsBluetooth(Object commsBluetooth) {
		this.commsBluetooth = commsBluetooth;
	}
	public Object getCommsGPS() {
		return commsGPS;
	}
	public void setCommsGPS(Object commsGPS) {
		this.commsGPS = commsGPS;
	}
	public Object getCommsNFC() {
		return commsNFC;
	}
	public void setCommsNFC(Object commsNFC) {
		this.commsNFC = commsNFC;
	}
	public Object getCommsRadio() {
		return commsRadio;
	}
	public void setCommsRadio(Object commsRadio) {
		this.commsRadio = commsRadio;
	}
	public Object getCommsUSB() {
		return commsUSB;
	}
	public void setCommsUSB(Object commsUSB) {
		this.commsUSB = commsUSB;
	}
	public Object getSensor() {
		return sensor;
	}
	public void setSensor(Object sensor) {
		this.sensor = sensor;
	}
	public Object getBatteryType() {
		return batteryType;
	}
	public void setBatteryType(Object batteryType) {
		this.batteryType = batteryType;
	}
	public Object getBatteryCapacity() {
		return batteryCapacity;
	}
	public void setBatteryCapacity(Object batteryCapacity) {
		this.batteryCapacity = batteryCapacity;
	}
	public Object getBatteryCharging() {
		return batteryCharging;
	}
	public void setBatteryCharging(Object batteryCharging) {
		this.batteryCharging = batteryCharging;
	}
	public Object getColors() {
		return colors;
	}
	public void setColors(Object colors) {
		this.colors = colors;
	}
	public String getRemovableUICC() {
		return removableUICC;
	}
	public void setRemovableUICC(String removableUICC) {
		this.removableUICC = removableUICC;
	}
	public String getRemovableEUICC() {
		return removableEUICC;
	}
	public void setRemovableEUICC(String removableEUICC) {
		this.removableEUICC = removableEUICC;
	}
	public Object getBandDetail() {
		return bandDetail;
	}
	public void setBandDetail(Object bandDetail) {
		this.bandDetail = bandDetail;
	}
	public Object getLaunchPriceAsianMarket() {
		return launchPriceAsianMarket;
	}
	public void setLaunchPriceAsianMarket(Object launchPriceAsianMarket) {
		this.launchPriceAsianMarket = launchPriceAsianMarket;
	}
	public Object getLaunchPriceUSMarket() {
		return launchPriceUSMarket;
	}
	public void setLaunchPriceUSMarket(Object launchPriceUSMarket) {
		this.launchPriceUSMarket = launchPriceUSMarket;
	}
	public Object getLaunchPriceEuropeMarket() {
		return launchPriceEuropeMarket;
	}
	public void setLaunchPriceEuropeMarket(Object launchPriceEuropeMarket) {
		this.launchPriceEuropeMarket = launchPriceEuropeMarket;
	}
	public Object getLaunchPriceInternationalMarket() {
		return launchPriceInternationalMarket;
	}
	public void setLaunchPriceInternationalMarket(Object launchPriceInternationalMarket) {
		this.launchPriceInternationalMarket = launchPriceInternationalMarket;
	}
	public Object getLaunchPriceCambodiaMarket() {
		return launchPriceCambodiaMarket;
	}
	public void setLaunchPriceCambodiaMarket(Object launchPriceCambodiaMarket) {
		this.launchPriceCambodiaMarket = launchPriceCambodiaMarket;
	}
	public Object getCustomPriceOfDevice() {
		return customPriceOfDevice;
	}
	public void setCustomPriceOfDevice(Object customPriceOfDevice) {
		this.customPriceOfDevice = customPriceOfDevice;
	}
	public Object getSourceOfCambodiaMarketPrice() {
		return sourceOfCambodiaMarketPrice;
	}
	public void setSourceOfCambodiaMarketPrice(Object sourceOfCambodiaMarketPrice) {
		this.sourceOfCambodiaMarketPrice = sourceOfCambodiaMarketPrice;
	}
	public Object getReportedGlobalIssue() {
		return reportedGlobalIssue;
	}
	public void setReportedGlobalIssue(Object reportedGlobalIssue) {
		this.reportedGlobalIssue = reportedGlobalIssue;
	}
	public Object getReportedLocalIssue() {
		return reportedLocalIssue;
	}
	public void setReportedLocalIssue(Object reportedLocalIssue) {
		this.reportedLocalIssue = reportedLocalIssue;
	}
	public Integer getDeviceState() {
		return deviceState;
	}
	public void setDeviceState(Integer deviceState) {
		this.deviceState = deviceState;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public Integer getUserType() {
		return userType;
	}
	public void setUserType(Integer userType) {
		this.userType = userType;
	}
	public Object getRemark() {
		return remark;
	}
	public void setRemark(Object remark) {
		this.remark = remark;
	}
	public Integer getFeatureId() {
		return featureId;
	}
	public void setFeatureId(Integer featureId) {
		this.featureId = featureId;
	}
	public String getUserDisplayName() {
		return userDisplayName;
	}
	public void setUserDisplayName(String userDisplayName) {
		this.userDisplayName = userDisplayName;
	}
	public Object getPublicIp() {
		return publicIp;
	}
	public void setPublicIp(Object publicIp) {
		this.publicIp = publicIp;
	}
	public Object getBrowser() {
		return browser;
	}
	public void setBrowser(Object browser) {
		this.browser = browser;
	}
	public String getStateInterp() {
		return stateInterp;
	}
	public void setStateInterp(String stateInterp) {
		this.stateInterp = stateInterp;
	}
	public Object getEsimSupportInterp() {
		return esimSupportInterp;
	}
	public void setEsimSupportInterp(Object esimSupportInterp) {
		this.esimSupportInterp = esimSupportInterp;
	}
	public Object getSoftsimSupportInterp() {
		return softsimSupportInterp;
	}
	public void setSoftsimSupportInterp(Object softsimSupportInterp) {
		this.softsimSupportInterp = softsimSupportInterp;
	}
	public Object getNetworkTechnologyGSMInterp() {
		return networkTechnologyGSMInterp;
	}
	public void setNetworkTechnologyGSMInterp(Object networkTechnologyGSMInterp) {
		this.networkTechnologyGSMInterp = networkTechnologyGSMInterp;
	}
	public Object getNetworkTechnologyCDMAInterp() {
		return networkTechnologyCDMAInterp;
	}
	public void setNetworkTechnologyCDMAInterp(Object networkTechnologyCDMAInterp) {
		this.networkTechnologyCDMAInterp = networkTechnologyCDMAInterp;
	}
	public Object getNetworkTechnologyEVDOInterp() {
		return networkTechnologyEVDOInterp;
	}
	public void setNetworkTechnologyEVDOInterp(Object networkTechnologyEVDOInterp) {
		this.networkTechnologyEVDOInterp = networkTechnologyEVDOInterp;
	}
	public Object getNetworkTechnologyLTEInterp() {
		return networkTechnologyLTEInterp;
	}
	public void setNetworkTechnologyLTEInterp(Object networkTechnologyLTEInterp) {
		this.networkTechnologyLTEInterp = networkTechnologyLTEInterp;
	}
	public Object getNetworkTechnology5GInterp() {
		return networkTechnology5GInterp;
	}
	public void setNetworkTechnology5GInterp(Object networkTechnology5GInterp) {
		this.networkTechnology5GInterp = networkTechnology5GInterp;
	}
	public Object getNetworkTechnology6GInterp() {
		return networkTechnology6GInterp;
	}
	public void setNetworkTechnology6GInterp(Object networkTechnology6GInterp) {
		this.networkTechnology6GInterp = networkTechnology6GInterp;
	}
	public Object getNetworkTechnology7GInterp() {
		return networkTechnology7GInterp;
	}
	public void setNetworkTechnology7GInterp(Object networkTechnology7GInterp) {
		this.networkTechnology7GInterp = networkTechnology7GInterp;
	}
	public Object getMemoryCardSlotInterp() {
		return memoryCardSlotInterp;
	}
	public void setMemoryCardSlotInterp(Object memoryCardSlotInterp) {
		this.memoryCardSlotInterp = memoryCardSlotInterp;
	}
	public Object getMainCameraTypeInterp() {
		return mainCameraTypeInterp;
	}
	public void setMainCameraTypeInterp(Object mainCameraTypeInterp) {
		this.mainCameraTypeInterp = mainCameraTypeInterp;
	}
	public Object getSelfieCameraTypeInterp() {
		return selfieCameraTypeInterp;
	}
	public void setSelfieCameraTypeInterp(Object selfieCameraTypeInterp) {
		this.selfieCameraTypeInterp = selfieCameraTypeInterp;
	}
	public Object getSoundLoudspeakerInterp() {
		return soundLoudspeakerInterp;
	}
	public void setSoundLoudspeakerInterp(Object soundLoudspeakerInterp) {
		this.soundLoudspeakerInterp = soundLoudspeakerInterp;
	}
	public Object getSound35mmJackInterp() {
		return sound35mmJackInterp;
	}
	public void setSound35mmJackInterp(Object sound35mmJackInterp) {
		this.sound35mmJackInterp = sound35mmJackInterp;
	}
	public Object getCommsNFCInterp() {
		return commsNFCInterp;
	}
	public void setCommsNFCInterp(Object commsNFCInterp) {
		this.commsNFCInterp = commsNFCInterp;
	}
	public Object getCommsRadioInterp() {
		return commsRadioInterp;
	}
	public void setCommsRadioInterp(Object commsRadioInterp) {
		this.commsRadioInterp = commsRadioInterp;
	}
	public List<Object> getAttachedFiles() {
		return attachedFiles;
	}
	public void setAttachedFiles(List<Object> attachedFiles) {
		this.attachedFiles = attachedFiles;
	}
	public List<String> getUpdateColumns() {
		return updateColumns;
	}
	public void setUpdateColumns(List<String> updateColumns) {
		this.updateColumns = updateColumns;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("DeviceManagementContentModel [id=");
		builder.append(id);
		builder.append(", createdOn=");
		builder.append(createdOn);
		builder.append(", modifiedOn=");
		builder.append(modifiedOn);
		builder.append(", deviceId=");
		builder.append(deviceId);
		builder.append(", marketingName=");
		builder.append(marketingName);
		builder.append(", manufacturer=");
		builder.append(manufacturer);
		builder.append(", manufacturingLocation=");
		builder.append(manufacturingLocation);
		builder.append(", modelName=");
		builder.append(modelName);
		builder.append(", brandName=");
		builder.append(brandName);
		builder.append(", oem=");
		builder.append(oem);
		builder.append(", organizationId=");
		builder.append(organizationId);
		builder.append(", deviceType=");
		builder.append(deviceType);
		builder.append(", allocationDate=");
		builder.append(allocationDate);
		builder.append(", imeiQuantity=");
		builder.append(imeiQuantity);
		builder.append(", simSlot=");
		builder.append(simSlot);
		builder.append(", esimSupport=");
		builder.append(esimSupport);
		builder.append(", softsimSupport=");
		builder.append(softsimSupport);
		builder.append(", simType=");
		builder.append(simType);
		builder.append(", os=");
		builder.append(os);
		builder.append(", osBaseVersion=");
		builder.append(osBaseVersion);
		builder.append(", announceDate=");
		builder.append(announceDate);
		builder.append(", launchDate=");
		builder.append(launchDate);
		builder.append(", deviceStatus=");
		builder.append(deviceStatus);
		builder.append(", discontinueDate=");
		builder.append(discontinueDate);
		builder.append(", networkTechnologyGSM=");
		builder.append(networkTechnologyGSM);
		builder.append(", networkTechnologyCDMA=");
		builder.append(networkTechnologyCDMA);
		builder.append(", networkTechnologyEVDO=");
		builder.append(networkTechnologyEVDO);
		builder.append(", networkTechnologyLTE=");
		builder.append(networkTechnologyLTE);
		builder.append(", networkTechnology5G=");
		builder.append(networkTechnology5G);
		builder.append(", networkTechnology6G=");
		builder.append(networkTechnology6G);
		builder.append(", networkTechnology7G=");
		builder.append(networkTechnology7G);
		builder.append(", network2GBand=");
		builder.append(network2GBand);
		builder.append(", network3GBand=");
		builder.append(network3GBand);
		builder.append(", network4GBand=");
		builder.append(network4GBand);
		builder.append(", network5GBand=");
		builder.append(network5GBand);
		builder.append(", network6GBand=");
		builder.append(network6GBand);
		builder.append(", network7GBand=");
		builder.append(network7GBand);
		builder.append(", networkSpeed=");
		builder.append(networkSpeed);
		builder.append(", bodyDimension=");
		builder.append(bodyDimension);
		builder.append(", bodyWeight=");
		builder.append(bodyWeight);
		builder.append(", displayType=");
		builder.append(displayType);
		builder.append(", displaySize=");
		builder.append(displaySize);
		builder.append(", displayResolution=");
		builder.append(displayResolution);
		builder.append(", displayProtection=");
		builder.append(displayProtection);
		builder.append(", platformChipset=");
		builder.append(platformChipset);
		builder.append(", platformCPU=");
		builder.append(platformCPU);
		builder.append(", platformGPU=");
		builder.append(platformGPU);
		builder.append(", memoryCardSlot=");
		builder.append(memoryCardSlot);
		builder.append(", memoryInternal=");
		builder.append(memoryInternal);
		builder.append(", ram=");
		builder.append(ram);
		builder.append(", mainCameraType=");
		builder.append(mainCameraType);
		builder.append(", mainCameraSpec=");
		builder.append(mainCameraSpec);
		builder.append(", mainCameraFeature=");
		builder.append(mainCameraFeature);
		builder.append(", mainCameraVideo=");
		builder.append(mainCameraVideo);
		builder.append(", selfieCameraType=");
		builder.append(selfieCameraType);
		builder.append(", selfieCameraSpec=");
		builder.append(selfieCameraSpec);
		builder.append(", selfieCameraFeature=");
		builder.append(selfieCameraFeature);
		builder.append(", selfieCameraVideo=");
		builder.append(selfieCameraVideo);
		builder.append(", soundLoudspeaker=");
		builder.append(soundLoudspeaker);
		builder.append(", sound35mmJack=");
		builder.append(sound35mmJack);
		builder.append(", commsWLAN=");
		builder.append(commsWLAN);
		builder.append(", commsBluetooth=");
		builder.append(commsBluetooth);
		builder.append(", commsGPS=");
		builder.append(commsGPS);
		builder.append(", commsNFC=");
		builder.append(commsNFC);
		builder.append(", commsRadio=");
		builder.append(commsRadio);
		builder.append(", commsUSB=");
		builder.append(commsUSB);
		builder.append(", sensor=");
		builder.append(sensor);
		builder.append(", batteryType=");
		builder.append(batteryType);
		builder.append(", batteryCapacity=");
		builder.append(batteryCapacity);
		builder.append(", batteryCharging=");
		builder.append(batteryCharging);
		builder.append(", colors=");
		builder.append(colors);
		builder.append(", removableUICC=");
		builder.append(removableUICC);
		builder.append(", removableEUICC=");
		builder.append(removableEUICC);
		builder.append(", bandDetail=");
		builder.append(bandDetail);
		builder.append(", launchPriceAsianMarket=");
		builder.append(launchPriceAsianMarket);
		builder.append(", launchPriceUSMarket=");
		builder.append(launchPriceUSMarket);
		builder.append(", launchPriceEuropeMarket=");
		builder.append(launchPriceEuropeMarket);
		builder.append(", launchPriceInternationalMarket=");
		builder.append(launchPriceInternationalMarket);
		builder.append(", launchPriceCambodiaMarket=");
		builder.append(launchPriceCambodiaMarket);
		builder.append(", customPriceOfDevice=");
		builder.append(customPriceOfDevice);
		builder.append(", sourceOfCambodiaMarketPrice=");
		builder.append(sourceOfCambodiaMarketPrice);
		builder.append(", reportedGlobalIssue=");
		builder.append(reportedGlobalIssue);
		builder.append(", reportedLocalIssue=");
		builder.append(reportedLocalIssue);
		builder.append(", deviceState=");
		builder.append(deviceState);
		builder.append(", userId=");
		builder.append(userId);
		builder.append(", userType=");
		builder.append(userType);
		builder.append(", remark=");
		builder.append(remark);
		builder.append(", featureId=");
		builder.append(featureId);
		builder.append(", userDisplayName=");
		builder.append(userDisplayName);
		builder.append(", publicIp=");
		builder.append(publicIp);
		builder.append(", browser=");
		builder.append(browser);
		builder.append(", stateInterp=");
		builder.append(stateInterp);
		builder.append(", esimSupportInterp=");
		builder.append(esimSupportInterp);
		builder.append(", softsimSupportInterp=");
		builder.append(softsimSupportInterp);
		builder.append(", networkTechnologyGSMInterp=");
		builder.append(networkTechnologyGSMInterp);
		builder.append(", networkTechnologyCDMAInterp=");
		builder.append(networkTechnologyCDMAInterp);
		builder.append(", networkTechnologyEVDOInterp=");
		builder.append(networkTechnologyEVDOInterp);
		builder.append(", networkTechnologyLTEInterp=");
		builder.append(networkTechnologyLTEInterp);
		builder.append(", networkTechnology5GInterp=");
		builder.append(networkTechnology5GInterp);
		builder.append(", networkTechnology6GInterp=");
		builder.append(networkTechnology6GInterp);
		builder.append(", networkTechnology7GInterp=");
		builder.append(networkTechnology7GInterp);
		builder.append(", memoryCardSlotInterp=");
		builder.append(memoryCardSlotInterp);
		builder.append(", mainCameraTypeInterp=");
		builder.append(mainCameraTypeInterp);
		builder.append(", selfieCameraTypeInterp=");
		builder.append(selfieCameraTypeInterp);
		builder.append(", soundLoudspeakerInterp=");
		builder.append(soundLoudspeakerInterp);
		builder.append(", sound35mmJackInterp=");
		builder.append(sound35mmJackInterp);
		builder.append(", commsNFCInterp=");
		builder.append(commsNFCInterp);
		builder.append(", commsRadioInterp=");
		builder.append(commsRadioInterp);
		builder.append(", attachedFiles=");
		builder.append(attachedFiles);
		builder.append(", updateColumns=");
		builder.append(updateColumns);
		builder.append(", networkSpecificIdentifier=");
		builder.append(networkSpecificIdentifier);
		builder.append("]");
		return builder.toString();
	}
	
	
	
}
