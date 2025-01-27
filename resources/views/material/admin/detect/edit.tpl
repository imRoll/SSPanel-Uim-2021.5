{include file='admin/main.tpl'}
<div id="layoutSidenav_content">
    <main>
        <header class="page-header page-header-dark bg-gradient-primary-to-secondary pb-10">
            <div class="container-xl px-4">
                <div class="page-header-content pt-4">
                    <div class="row align-items-center justify-content-between">
                        <div class="col-auto mt-4">
                            <h1 class="page-header-title">
                                编辑规则 #{$rule->id}
                            </h1>
                        </div>
                        <div class="col-12 col-xl-auto mt-4">{$rule->name}</div>
                    </div>
                </div>
            </div>
        </header>
        <div class="container-xl px-4 mt-n10">
            <form id="main_form">
                <div class="card">
                    <div class="card-body">
                        <div class="mb-3">
                            <label class="form-label" for="name">规则名称</label>
                            <input class="form-control maxwidth-edit" id="name" name="name" type="text"
                                value="{$rule->name}">
                        </div>
                        <div class="mb-3">
                            <label class="form-label" for="text">规则描述</label>
                            <input class="form-control maxwidth-edit" id="text" name="text" type="text"
                                value="{$rule->text}">
                        </div>
                        <div class="mb-3">
                            <label class="form-label" for="regex">规则正则表达式</label>
                            <input class="form-control maxwidth-edit" id="regex" name="regex" type="text"
                                value="{$rule->regex}">
                        </div>
                        <div class="mb-3">
                            <div class="mb-3">
                                <label class="form-label" for="type">规则类型</label>
                                <select id="type" class="form-control maxwidth-edit" name="type">
                                    <option value="1" {if $rule->type == 1}selected{/if}>数据包明文匹配</option>
                                    <option value="2" {if $rule->type == 2}selected{/if}>数据包 hex 匹配</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <div class="d-grid gap-2">
                            <button id="submit" type="submit" class="btn btn-primary btn-block">修改
                            </button>
                        </div>
                    </div>

            </form>
            {include file='dialog.tpl'}
        </div>
    </main>
    <!-- Footer -->
    <footer class="footer-admin mt-auto footer-light">
        <div class="container-xl px-4">
            <div class="row">
                <div class="col-md-12 text-center small">&copy;{date("Y")} {$config['appName']} ©
                    Powered by <a href="/staff">SSPANEL</a>
                    {if $config['enable_analytics_code'] === true}{include file='analytics.tpl'}{/if}
                </div>
            </div>
        </div>
    </footer>
    <!-- End of Footer -->
</div>
{include file='admin/footer.tpl'}

<script>
    $('#main_form').validate({
        {literal}
            rules: {
                name: {required: true},
                text: {required: true},
                regex: {required: true}
            },
        {/literal}
        submitHandler: function() {
            $.ajax({
                type: "PUT",
                url: "/admin/detect/{$rule->id}",
                dataType: "json",

                data: {
                    name: $$getValue("name"),
                    text: $$getValue("text"),
                    regex: $$getValue("regex"),
                    type: $$getValue("type")
                },
                success: data => {
                    if (data.ret) {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                        window.setTimeout("location.href=top.document.referrer", {$config['jump_delay']});
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    }
                },
                error: data => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `${ldelim}data.msg{rdelim} 发生错误了。`;
                }
            });
        }
    });
</script>
