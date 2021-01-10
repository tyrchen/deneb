defmodule Deneb.Viewer do
  @moduledoc """
  Vega-lite chart viewer
  """

  @cdn_url ~S"https://cdn.jsdelivr.net/npm/<%= package %>@<%= version %>"

  @versions %{
    "vega" => Deneb.MixProject.vega(),
    "vega-lite" => Deneb.MixProject.vega_lite(),
    "vega-embed" => Deneb.MixProject.vega_embed()
  }

  @inline_html ~S"""
  <div id="<%= output_div %>"></div>
  <script type="text/javascript">
  (function(spec, embedOpt) {
    const outputDiv = document.getElementById("<%= output_div %>");
    const urls = {
      "vega": "<%= vega %>",
      "vega-lite": "<%= vega_lite %>",
      "vega-embed": "<%= vega_embed %>",
    };
    function loadScript(lib) {
      return new Promise(function(resolve, reject) {
        var s = document.createElement('script');
        s.src = urls[lib];
        s.async = true;
        s.onload = () => resolve(urls[lib]);
        s.onerror = () => reject(`Error loading script: ${urls[lib]}`);
        document.getElementsByTagName("head")[0].appendChild(s);
      });
    }
    function showError(err) {
      outputDiv.innerHTML = `<div class="error" style="color:red;">${err}</div>`;
      throw err;
    }
    function displayChart(vegaEmbed) {
      vegaEmbed(outputDiv, spec, embedOpt)
        .catch(err => showError(`Javascript Error: ${err.message}<br>This usually means there's a typo in your chart specification. See the javascript console for the full traceback.`));
    }
    if(typeof define === "function" && define.amd) {
        // requirejs paths need '.js' extension stripped.
        const paths = Object.keys(urls).reduce(function(paths, package) {
            paths[package] = urls[package].replace(/\.js$/, "");
            return paths
        }, {})
        requirejs.config({paths});
        require(["vega-embed"], displayChart, err => showError(`Error loading script: ${err.message}`));
    } else if (typeof vegaEmbed === "function") {
        displayChart(vegaEmbed);
    } else {
        loadScript("vega")
            .then(() => loadScript("vega-lite"))
            .then(() => loadScript("vega-embed"))
            .catch(showError)
            .then(() => displayChart(vegaEmbed));
    }
  })(<%= spec %>, <%= opts %>);
  </script>
  """

  def display(chart, opts \\ %{}) do
    output_div = "deneb-chart-#{UUID.uuid4(:hex)}"
    vega = package_url("vega")
    vega_lite = package_url("vega-lite")
    vega_embed = package_url("vega-embed")

    spec = Jason.encode!(chart)
    opts = Jason.encode!(opts)

    EEx.eval_string(@inline_html,
      output_div: output_div,
      vega: vega,
      vega_lite: vega_lite,
      vega_embed: vega_embed,
      spec: spec,
      opts: opts
    )
  end

  defp package_url(pkg) do
    EEx.eval_string(@cdn_url, package: pkg, version: @versions[pkg])
  end
end
