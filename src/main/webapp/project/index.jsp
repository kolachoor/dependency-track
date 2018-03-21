<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="e" uri="https://www.owasp.org/index.php/OWASP_Java_Encoder_Project" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="/WEB-INF/fragments/header.jsp"/>
    <title>Dependency-Track - Project Details</title>
</head>
<body data-sidebar="projects">
<jsp:include page="/WEB-INF/fragments/navbar.jsp"/>
<div id="content-container" class="container-fluid">
    <div class="widget-detail-row main">
        <div class="col-lg-12 col-md-12">
            <div class="panel widget">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-sm-6 col-md-6 col-lg-8">
                            <div class="title-icon">
                                <i class="fa fa-sitemap"></i>
                            </div>
                            <div class="title-container">
                                <span class="title">
                                    <span class="name" id="projectTitle"></span>
                                    <span id="projectVersion"></span>
                                </span>
                                <br/>Sub Project: 0<br/>
                                <span id="tags"></span>
                            </div>
                        </div>
                        <div class="col-sm-3 col-md-3 col-lg-2">
                            <table style="width:100%; height:85px;">
                                <tr>
                                    <td style="vertical-align: middle;">
                                        <table>
                                            <tr>
                                                <td width="100%"></td>
                                                <td nowrap><span class="severity-critical fa fa-circle-o"></span>&nbsp;Critical Severity:&nbsp;</td>
                                                <td nowrap><span id="metricCritical"></span></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td nowrap><span class="severity-high fa fa-circle-o"></span>&nbsp;High Severity:&nbsp;</td>
                                                <td nowrap><span id="metricHigh"></span></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td nowrap><span class="severity-medium fa fa-circle-o"></span>&nbsp;Medium Severity:&nbsp;</td>
                                                <td nowrap><span id="metricMedium"></span></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td nowrap><span class="severity-low fa fa-circle-o"></span>&nbsp;Low Severity:&nbsp;</td>
                                                <td nowrap><span id="metricLow"></span></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-sm-3 col-md-3 col-lg-2 text-right">
                            <div class="huge"><span id="metricIrs"></span></div>
                            <div>Inherited Risk Score</div>
                        </div>

                    </div>
                </div>
                <a href="#" class="widget-details-selector" data-toggle="modal" data-target="#modalDetails">
                    <div class="panel-footer">
                        <span class="pull-left">View Details</span>
                        <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                        <div class="clearfix"></div>
                    </div>
                </a>
            </div>
        </div>
    </div>
    <div class="content-row main">
        <div class="col-sm-12 col-md-12">
            <div id="componentsToolbar">
                <div class="form-inline" role="form">
                    <button id="addDependencyButton" class="btn btn-default" data-toggle="modal" data-target="#modalAddDependency"><span class="fa fa-plus"></span> Add Dependency</button>
                    <button id="removeDependencyButton" class="btn btn-default"><span class="fa fa-minus"></span> Remove Dependency</button>
                </div>
            </div>
            <table id="dependenciesTable" class="table table-hover detail-table" data-toggle="table"
                   data-url="<c:url value="/api/v1/dependency/project/${e:forUriComponent(param.uuid)}"/>" data-response-handler="formatDependenciesTable"
                   data-show-refresh="true" data-show-columns="true" data-search="true" data-detail-view="true"
                   data-query-params-type="pageSize" data-side-pagination="server" data-pagination="true"
                   data-page-size="10" data-page-list="[10, 25, 50, 100]"
                   data-toolbar="#componentsToolbar" data-click-to-select="true" data-height="100%">
                <thead>
                <tr>
                    <th data-align="center" data-field="state" data-checkbox="true"></th>
                    <th data-align="left" data-field="componenthref">Component</th>
                    <th data-align="left" data-field="component.version">Version</th>
                    <th data-align="left" data-field="component.group">Group</th>
                    <th data-align="left" data-field="component.license">License</th>
                    <th data-align="left" data-field="vulnerabilities">Vulnerabilities</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>

    <!-- Modals specific to a project -->
    <div class="modal" id="modalAddDependency" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <span class="modal-title">Add Dependency</span>
                </div>
                    <div class="panel with-nav-tabs panel-default tight panel-with-tabbed-modal-body">
                        <div class="panel-heading">
                            <ul class="nav nav-tabs">
                                <li class="active"><a href="#fromExistingTab" data-toggle="tab">From Existing Component</a></li>
                                <li><a href="#fromNewTab" data-toggle="tab">From New Component</a></li>
                            </ul>
                        </div>
                        <div class="panel-body tight">
                            <div class="tab-content">
                                <div class="tab-pane active" id="fromExistingTab">
                                    <div class="modal-body">
                                        <table id="componentsTable" class="table table-hover" data-toggle="table"
                                               data-url="<c:url value="/api/v1/component"/>" data-response-handler="formatComponentsTable"
                                               data-search="true" data-click-to-select="true" data-page-size="5"
                                               data-query-params-type="pageSize" data-side-pagination="server" data-pagination="true">
                                            <thead>
                                            <tr>
                                                <th data-align="center" data-field="state" data-checkbox="true"></th>
                                                <th data-align="left" data-field="name">Name</th>
                                                <th data-align="left" data-field="version">Version</th>
                                                <th data-align="left" data-field="group">Group</th>
                                            </tr>
                                            </thead>
                                        </table>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                        <button type="button" class="btn btn-primary" data-dismiss="modal" id="addDependencyFromExistingButton">Add Dependency</button>
                                    </div>
                                </div>
                                <div class="tab-pane" id="fromNewTab">
                                    <div class="modal-body">
                                        <div class="form-group">
                                            <label class="required" for="createComponentNameInput">Component Name</label>
                                            <input type="text" name="name" required="required" class="form-control required" id="createComponentNameInput">
                                        </div>
                                        <div class="form-group">
                                            <label class="required" for="createComponentVersionInput">Version</label>
                                            <input type="text" name="version" required="required" class="form-control required" id="createComponentVersionInput">
                                        </div>
                                        <div class="form-group">
                                            <label for="createComponentGroupInput">Group / Vendor</label>
                                            <input type="text" name="group" class="form-control" id="createComponentGroupInput">
                                        </div>
                                        <div class="form-group">
                                            <label for="createComponentDescriptionInput">Description</label>
                                            <textarea name="description" class="form-control" id="createComponentDescriptionInput"></textarea>
                                        </div>
                                        <div class="form-group">
                                            <label for="createComponentLicenseSelect">License</label>
                                            <select name="license" class="selectpicker form-control" title="License / Nothing selected..." data-live-search="true" id="createComponentLicenseSelect">
                                                <option></option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                        <button type="button" class="btn btn-primary" data-dismiss="modal" id="addDependencyFromNewButton">Add Dependency</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalDetails" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <span class="modal-title">Project Details</span>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label class="required" for="projectNameInput">Project Name</label>
                        <input type="text" name="name" required="required" class="form-control required" id="projectNameInput">
                    </div>
                    <div class="form-group">
                        <label for="projectVersionInput">Version</label>
                        <input type="text" name="version" class="form-control" id="projectVersionInput">
                    </div>
                    <div class="form-group">
                        <label for="projectDescriptionInput">Description</label>
                        <textarea name="description" class="form-control" id="projectDescriptionInput"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="projectTagsInput">Tags</label>
                        <input type="text" name="tags" placeholder="Comma separated" class="form-control" data-role="tagsinput" id="projectTagsInput">
                    </div>
                    <table id="projectPropertiesTable" class="table">
                        <thead>
                            <tr>
                                <th>Key</th>
                                <th>Value</th>
                            </tr>
                        </thead>
                        <tbody id="projectPropertiesTableData">
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal" id="deleteProjectButton">Delete</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal" id="updateProjectButton">Update</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="/WEB-INF/fragments/common-modals.jsp"/>
<jsp:include page="/WEB-INF/fragments/footer.jsp"/>
<script type="text/javascript" src="<c:url value="/project/functions.js"/>"></script>
</body>
</html>