<%@page import="biblivre.core.utils.Constants"%>
<%@page import="biblivre.core.configurations.Configurations"%>
<%@page import="org.apache.commons.lang3.StringEscapeUtils"%>
<%@page import="biblivre.core.schemas.SchemaDTO"%>
<%@page import="biblivre.core.schemas.Schemas"%>
<%@page import="biblivre.core.ExtendedRequest"%>
<%@ page import="biblivre.login.LoginDTO "%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="layout" uri="/WEB-INF/tlds/layout.tld" %>
<%@ taglib prefix="i18n" uri="/WEB-INF/tlds/translations.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<layout:head>
	<link rel="stylesheet" type="text/css" href="static/styles/biblivre.index.css" />
	<link rel="stylesheet" type="text/css" href="static/styles/biblivre.multi_schema.css" />
</layout:head>

<layout:body>
	<%
	ExtendedRequest req = (ExtendedRequest) request;

	if (!req.isGlobalSchema()) {
		LoginDTO login = (LoginDTO) session.getAttribute(request.getAttribute("schema") + ".logged_user");
		pageContext.setAttribute("login", login);

		if (login != null) {
			pageContext.setAttribute("name", login.getFirstName());
		}
	%>

		<!-- EducaMar Hero Section -->
		<div class="edumar-hero">
			<div class="edumar-badge">&#127754; EducaMar &mdash; Biblioteca Digital</div>

			<div class="edumar-hero-content">
				<div class="edumar-hero-text">
					<h1>Mergulhe no <span class="edumar-highlight">Mar do Conhecimento</span></h1>

					<c:choose>
						<c:when test="${empty login}">
							<p>Acesse o acervo digital da nossa biblioteca e explore um universo de recursos educacionais e culturais ao alcance de um clique.</p>
							<div class="edumar-cta-buttons">
								<a href="?action=search_bibliographic" class="edumar-btn-primary">&#128269; Pesquisar Acervo</a>
								<a href="javascript:void(0)" onclick="Core.submitForm('login', 'login', 'jsp');" class="edumar-btn-outline">Fazer Login</a>
							</div>
						</c:when>
						<c:otherwise>
							<p>Bem-vindo(a), <strong>${name}</strong>! Explore o acervo, fa&ccedil;a reservas e gerencie seus empr&eacute;stimos.</p>
							<div class="edumar-cta-buttons">
								<a href="?action=search_bibliographic" class="edumar-btn-primary">&#128269; Pesquisar Acervo</a>
							</div>
						</c:otherwise>
					</c:choose>

					<div class="edumar-stats">
						<span class="edumar-stat"><span class="edumar-stat-check">&#10003;</span> Acesso Gratuito</span>
						<span class="edumar-stat"><span class="edumar-stat-check">&#10003;</span> Cat&aacute;logo Digital</span>
						<span class="edumar-stat"><span class="edumar-stat-check">&#10003;</span> F&aacute;cil de Usar</span>
					</div>
				</div>

				<div class="edumar-hero-image">
					<img src="static/images/main_picture_1.jpg" alt="Biblioteca EducaMar"/>
				</div>
			</div>
		</div>

		<!-- Features Section -->
		<div class="edumar-features">
			<h2 class="edumar-features-title">O que voc&ecirc; pode fazer</h2>

			<div class="edumar-cards">
				<div class="edumar-card">
					<span class="edumar-card-icon">&#128218;</span>
					<div class="edumar-card-title">Pesquisa Bibliogr&aacute;fica</div>
					<p class="edumar-card-text">Busque livros, artigos e documentos em nosso cat&aacute;logo completo e atualizado.</p>
				</div>

				<div class="edumar-card">
					<span class="edumar-card-icon">&#128260;</span>
					<div class="edumar-card-title">Empr&eacute;stimos e Reservas</div>
					<p class="edumar-card-text">Gerencie seus empr&eacute;stimos, fa&ccedil;a reservas e acompanhe seu hist&oacute;rico de leituras.</p>
				</div>

				<div class="edumar-card">
					<span class="edumar-card-icon">&#127758;</span>
					<div class="edumar-card-title">Acesso Digital</div>
					<p class="edumar-card-text">Acesse recursos digitais, m&iacute;dias e materiais educativos de qualquer lugar.</p>
				</div>
			</div>
		</div>

	<%
	} else {
	%>
		<div class="multischema biblivre_form">
			<fieldset>
				<legend><i18n:text key="text.multi_schema.select_library" /></legend>
				<% for (SchemaDTO schema : Schemas.getSchemas()) { %>
					<% if (schema.isDisabled()) { continue; } %>
					<div class="library">
						<a href="<%= schema.getSchema() %>/"><%= Configurations.getHtml(schema.getSchema(), Constants.CONFIG_TITLE) %></a>
						<div class="subtitle"><%= Configurations.getHtml(schema.getSchema(), Constants.CONFIG_SUBTITLE) %></div>
					</div>
				<% } %>
			</fieldset>
		</div>
	<%
	}
	%>
</layout:body>
