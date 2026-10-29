// www.loupe.mx → loupe.mx, keeping the path and query (301).
export default {
  fetch(request: Request): Response {
    const url = new URL(request.url);
    url.hostname = 'loupe.mx';
    url.protocol = 'https:';
    return Response.redirect(url.toString(), 301);
  },
};
