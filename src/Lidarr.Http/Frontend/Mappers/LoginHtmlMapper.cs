using System;
using System.IO;
using Nancy;
using NLog;
using NzbDrone.Common.Disk;
using NzbDrone.Common.EnvironmentInfo;
using NzbDrone.Core.Configuration;

namespace Lidarr.Http.Frontend.Mappers
{
    public class LoginHtmlMapper : HtmlMapperBase
    {
        private readonly IDiskProvider _diskProvider;
        private readonly string _indexPath;

        private string _generatedContent;

        public LoginHtmlMapper(IAppFolderInfo appFolderInfo,
                               IDiskProvider diskProvider,
                               Func<ICacheBreakerProvider> cacheBreakProviderFactory,
                               IConfigFileProvider configFileProvider,
                               Logger logger)
            : base(diskProvider, cacheBreakProviderFactory, logger)
        {
            HtmlPath = Path.Combine(appFolderInfo.StartUpFolder, configFileProvider.UiFolder, "login.html");
            UrlBase = configFileProvider.UrlBase;
        }

        public override string Map(string resourceUrl)
        {
            return HtmlPath;
        }

        public override bool CanHandle(string resourceUrl)
        {
            return resourceUrl.StartsWith("/login");
        }
    }
}
